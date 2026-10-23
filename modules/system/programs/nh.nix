{ config, lib, system, ... }:

let
  cfg = config.sysmods.nh;

  # -- generations rules
  keep = "--keep-since 7d --keep 3";
in
{
  options.sysmods.nh.enable = lib.mkEnableOption "nh (nix helper)";

  config = lib.mkIf cfg.enable {
    # -- settings
    programs.nh = {
      enable = true;
      flake = system.dotfiles;

      # -- garbage collector
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "${keep} --optimise";
      };
    };

    # -- shell shortcuts
    environment.shellAliases = {
      rebuild = "nh os switch";
      upgrade = "nh os switch --update";
      rollback = "nh os rollback";
      gens = "nh os info";
      clean = "nh clean all ${keep} --optimise";
    };
  };
}
