<div align="center">

# My NixOS Config

<br />

[![Last Commit](https://img.shields.io/github/last-commit/glockfatherdraco/mynix?style=flat-square)](https://github.com/glockfatherdraco/mynix/commits/main)

</div>

A simple [NixOS](https://nixos.org/) configuration with [COSMIC](https://system76.com/cosmic) desktop and evil Home Manager

> [!CAUTION]
> Still a work in progress. I'm learning Nix, so expect ~~retarded~~ questionable decisions

---

## Q&A section

<details>
<summary><b>Why does this configuration look like shit?</b></summary>

> I'm still learning

</details>

<details>
<summary><b>Why are most LibreWolf protections disabled?</b></summary>

> `sudo opsec`

</details>

<details>
<summary><b>Flatpak???</b></summary>

> `"space.bigrat.mocktail"`

> Life is Roblox

</details>

<details>
<summary><b>Why do you use a firewall?</b></summary>

> I play outdated P2P games with a quadrillion vulnerabilities and usually get things from torrents. When I'm not doing anything with the firewall, it just acts as an extra layer of security for me because I'm paranoid that my Huawei router is going to hack me and send all my data to the CCP

</details>

<details>
<summary><b>Why NixOS?</b></summary>

> Because I simply love torturing myself instead of using any user friendly distro based on Ubuntu

</details>

<details>
<summary><b>Why COSMIC?</b></summary>

> I love [libcosmic](https://github.com/pop-os/libcosmic)

</details>

### Installation (fresh install, no DE)

<details>
<summary><b>Commands</b></summary>

```
nix-shell -p git
```

```
sudo rm -rf /etc/nixos
```

```
sudo git clone https://github.com/glockfatherdraco/mynix.git /etc/nixos
```

```
sudo nixos-generate-config
```

```
sudo rm -rf /etc/nixos/.git
```

```
nix flake lock /etc/nixos
```

```
sudo nixos-rebuild switch --flake /etc/nixos#nix
```

</details>
