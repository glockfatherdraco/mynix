<div align="center">

# My NixOS Config

<br />

[![Last Commit](https://img.shields.io/github/last-commit/glockfatherdraco/nixos-config?style=flat-square)](https://github.com/glockfatherdraco/nixos-config/commits/main)

</div>

A single user [NixOS](https://nixos.org/) configuration with [COSMIC](https://system76.com/cosmic) desktop and Home Manager

> [!CAUTION]
> Still a work in progress. I'm learning Nix, so expect ~~retarded~~ questionable decisions

---

## Q&A section

<details>
<summary><b>Why does this configuration look like shit?</b></summary>

> idk just leave me alone bro

</details>

<details>
<summary><b>Why are most libreWolf protections disabled?</b></summary>

> `sudo opsec`

</details>

<details>
<summary><b>Why do you use a firewall?</b></summary>

> opsec level: nftables

</details>

<details>
<summary><b>Why COSMIC?</b></summary>

> I love [libcosmic](https://github.com/pop-os/libcosmic)

</details>

### Installation (notes for me)

<details>
<summary><b>Commands</b></summary>

```
nix-shell -p git --run "sudo git clone https://github.com/glockfatherdraco/nixos-config.git /etc/nixos"
```

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode destroy,format,mount --flake /etc/nixos#nix \
&& sudo nixos-install --flake /mnt/etc/nixos#nix --no-channel-copy --no-root-password
```

```
sudo nixos-enter --root /mnt -c "passwd gfd"
```

</details>
