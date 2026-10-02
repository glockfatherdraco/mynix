{ config, lib, system, ... }:

let
  cfg = config.userSettings.shell;
in
{
  options.userSettings.shell.enable = lib.mkEnableOption "fish shell";

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set -g fish_greeting
      '' + lib.optionalString config.userSettings.fastfetch.enable ''
        fastfetch
      '';

      shellAliases = {
        rebuild = "sudo nixos-rebuild switch --flake ${system.dotfilesDir}#${system.hostname}";
        rollback = "sudo nixos-rebuild switch --rollback";
        check = "sudo nix flake check ${system.dotfilesDir}";
        update = "sudo nix flake update --flake ${system.dotfilesDir}";
        clean = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
        gens = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";

        home = "cd ${config.home.homeDirectory}/";
        edit = "cd ${system.dotfilesDir}";
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
  };
}
