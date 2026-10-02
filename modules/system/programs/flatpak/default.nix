{ config, lib, pkgs, ... }:

let
  cfg = config.systemSettings.flatpak;
in
{
  options.systemSettings.flatpak = {
    enable = lib.mkEnableOption "Flatpak";

    packages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "flatpak apps";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = lib.optional (config.systemSettings.desktop == "none") pkgs.xdg-desktop-portal-gtk;
      config = lib.mkIf (config.systemSettings.desktop == "none") {
        common.default = "*";
      };
    };

    services.flatpak = {
      enable = true;
      uninstallUnmanaged = true;

      update.auto = {
        enable = true;
        onCalendar = "daily";
      };

      inherit (cfg) packages;
    };

    # Makes Flatpak wait for a network connection before updating
    systemd.services.flatpak-managed-install.unitConfig = {
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
  };
}
