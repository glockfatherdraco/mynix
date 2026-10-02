{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.gaming;
in
{
  options.systemSettings.gaming = {
    enable = lib.mkEnableOption "gaming apps";
  };

  config = lib.mkIf cfg.enable {

    programs.gamemode.enable = true;
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;

      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    environment.systemPackages = [
      pkgs.gamemode
      pkgs.mangohud
      pkgs.protonplus
      pkgs.prismlauncher
      pkgs.r2modman
    ];
  };
}
