{ config, lib, pkgs, ... }:

let
  cfg = config.sysmods.gaming;
in
{
  options.sysmods.gaming.enable = lib.mkEnableOption "gaming";

  config = lib.mkIf cfg.enable {
    programs.gamemode.enable = true;
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      protonplus
      prismlauncher
      r2modman
    ];
  };
}
