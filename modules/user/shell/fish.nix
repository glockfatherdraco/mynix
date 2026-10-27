{ config, system, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting
    '';

    shellAliases = {
      check = "nix flake check ${system.dotfiles}";
      update = "nix flake update --flake ${system.dotfiles}";

      home = "cd ${config.home.homeDirectory}/";
      edit = "cd ${system.dotfiles}";
      cleartrash = "gio trash --empty";

      ll = "ls -lah";
      la = "ls -A";

      restart = "sudo reboot";
      off = "sudo poweroff";
    };
  };
}
