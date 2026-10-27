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
      extraCompatPackages = [ pkgs.proton-cachyos-x86_64-v3 ];
    };

    environment.systemPackages = with pkgs; [
      mangohud
      prismlauncher
      r2modman
    ];
  };
}
