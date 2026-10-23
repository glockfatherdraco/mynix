#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

FLAKE=${FLAKE:-/etc/nixos}
HOST=${HOST:-nix}
USERNAME=${USERNAME:-gfd}
LOG=/tmp/install.log
KEYFILE=/tmp/disk.key
KEYS_FROM=""
DRY_RUN=0
SET_PASSWORD=1

while [[ $# -gt 0 ]]; do
  case $1 in
    --host) HOST=$2; shift 2 ;;
    --flake) FLAKE=$2; shift 2 ;;
    --user) USERNAME=$2; shift 2 ;;
    --keys-from) KEYS_FROM=$2; shift 2 ;;
    --no-passwd) SET_PASSWORD=0; shift ;;
    --dry-run) DRY_RUN=1; shift ;;
    -h|--help) exit 0 ;;
    *) echo "Error: unknown option '$1'" >&2; exit 1 ;;
  esac
done

die() { echo "Error: $*" >&2; exit 1; }
step() { echo "==> $*"; }

[[ $EUID -eq 0 ]] || die "Root privileges required (use sudo)"

exec > >(tee -a "$LOG") 2>&1

SBCTL_BOUND=""
unbind_pki() {
  [[ -n $SBCTL_BOUND ]] || return 0
  umount "$SBCTL_BOUND" 2>/dev/null || true
  SBCTL_BOUND=""
}
cleanup() {
  unbind_pki
  [[ -e $KEYFILE ]] && { shred -u "$KEYFILE" 2>/dev/null || rm -f "$KEYFILE"; }
}
on_err() {
  echo "Failed at line $1. Check $LOG." >&2
}
trap cleanup EXIT
trap 'on_err $LINENO' ERR

export NIX_CONFIG="experimental-features = nix-command flakes"
export GIT_CONFIG_COUNT=1 GIT_CONFIG_KEY_0=safe.directory GIT_CONFIG_VALUE_0="$FLAKE"
ATTR="$FLAKE#nixosConfigurations.\"$HOST\""

eval_attr() { nix eval --raw "$ATTR.$1"; }
build_attr() { nix build --no-link --print-out-paths "$ATTR.$1"; }

# ---- preflight
[[ -e $FLAKE/flake.nix ]] || die "Flake not found at $FLAKE"
[[ -d /sys/firmware/efi ]] || die "UEFI mode required"
curl -fsI --max-time 10 https://cache.nixos.org >/dev/null || die "Network unreachable"

step "Evaluating configuration"
DISK=$(eval_attr config.disko.devices.disk.main.device) \
  || die "Disk device not configured"
[[ -e $DISK ]] || die "Disk not found: $DISK"
REAL=$(readlink -f "$DISK")
DISK_NAME=$(basename "$REAL")
PKI=$(eval_attr config.boot.lanzaboote.pkiBundle) \
  || die "Lanzaboote PKI bundle not found"

if [[ -n $(lsblk -nro MOUNTPOINTS "$REAL" | tr -d '[:space:]') ]]; then
  die "Disk has active mounts: $REAL"
fi
KEYS_MODE=generate
if [[ -n $KEYS_FROM ]]; then
  [[ -d $KEYS_FROM ]] || die "Keys directory not found: $KEYS_FROM"
  [[ -e $KEYS_FROM/keys/PK/PK.key || -e $KEYS_FROM/PK/PK.key ]] || die "No sbctl keys found in $KEYS_FROM"
  KEYS_MODE=restore
fi

echo
echo "Host:     $HOST"
echo "Disk:     $REAL"
echo "Keys:     $PKI ($KEYS_MODE)"
lsblk -o NAME,SIZE,MODEL "$REAL"

if [[ $DRY_RUN -eq 1 ]]; then
  step "Dry run: checks passed."
  exit 0
fi

echo
echo "WARNING: This will wipe $REAL"
read -rp "Confirm disk name ($DISK_NAME): " ans
[[ $ans == "$DISK_NAME" ]] || die "Aborted"

# ---- LUKS passphrase
while :; do
  read -rsp "LUKS passphrase: " p1; echo
  read -rsp "Confirm passphrase: " p2; echo
  [[ -n $p1 && $p1 == "$p2" ]] && break
  echo "Passphrases do not match. Try again."
done
printf '%s' "$p1" > "$KEYFILE"
unset p1 p2

# ---- partition, encrypt, mount
step "Building disko script"
DISKO=$(build_attr config.system.build.diskoScript)

step "Partitioning and encrypting"
"$DISKO"
mountpoint -q /mnt || die "Mount failed: /mnt"

# ---- Secure Boot
step "Setting up Secure Boot keys"
mkdir -p "/mnt$PKI" "$PKI"
chmod 700 "/mnt$PKI"
if [[ $KEYS_MODE == restore ]]; then
  cp -a "$KEYS_FROM/." "/mnt$PKI/"
else
  SBCTL=$(build_attr pkgs.sbctl)/bin/sbctl
  mount --bind "/mnt$PKI" "$PKI"
  SBCTL_BOUND=$PKI
  "$SBCTL" create-keys
  unbind_pki
fi
[[ -n $(ls -A "/mnt$PKI") ]] || die "Secure Boot keys missing"

# ---- Install
step "Copying configuration"
mkdir -p /mnt/etc/nixos
cp -a "$FLAKE/." /mnt/etc/nixos/

step "Installing NixOS"
nixos-install --root /mnt --flake "$FLAKE#$HOST" --no-root-password

if [[ $SET_PASSWORD -eq 1 ]]; then
  step "Setting user password ($USERNAME)"
  ok=0
  for _ in 1 2 3; do
    if nixos-enter --root /mnt -c "passwd $USERNAME"; then ok=1; break; fi
    echo "Try again."
  done
  [[ $ok -eq 1 ]] || echo "Warning: Password not set. Run 'passwd $USERNAME' after reboot." >&2
fi

echo
step "Installation complete."

read -rp "Reboot now? [y/N] " r
if [[ $r == [yY] ]]; then
  umount -R /mnt
  reboot
fi
