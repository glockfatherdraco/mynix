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

> sudo opsec

</details>

<details>
<summary><b>Why NixOS?</b></summary>

> sudo opsec

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
git clone https://github.com/glockfatherdraco/mynix.git /etc/nixos
```

```
sudo nixos-generate-config
```

```
nix flake lock /etc/nixos
```

```
sudo nixos-rebuild switch --flake /etc/nixos#nix
```

</details>
