# Notes

## Installation

<details>
<summary><b>Commands</b></summary>

```
nix-shell -p git --run "sudo git clone https://github.com/glockfatherdraco/nixos-config.git /etc/nixos"
```

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount --flake /etc/nixos#nix \
&& sudo nixos-install --flake /etc/nixos#nix --no-channel-copy --no-root-password \
&& sudo mkdir -p /mnt/etc && sudo cp -r /etc/nixos /mnt/etc/nixos
```

```
sudo nixos-enter --root /mnt -c "passwd gfd"
```

</details>

## Re-enroll keys into TPM

```
sudo systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm2-pcrlock=/var/lib/systemd/pcrlock.json /dev/nvme0n1p2
```
