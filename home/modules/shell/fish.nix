{ host, username, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
    '';

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#${host}";
      rollback = "sudo nixos-rebuild switch --rollback";
      check = "nix flake check /etc/nixos";
      update = "nix flake update /etc/nixos";
      clean = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
      gens = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

      home = "cd /home/${username}/";
      edit = "cd /etc/nixos";
      cleartrash = "gio trash --empty";

      ll = "ls -lah";
      la = "ls -A";

      restart = "sudo reboot";
      off = "sudo poweroff";

      sn = "sudo nano";
      bh = "bash";
      ff = "fastfetch";
    };
  };
}
