{ config, lib, flatpaks, ... }:

let
  cfg = config.sysmods.flatpak;
in
{
  options.sysmods.flatpak.enable = lib.mkEnableOption "declarative flatpak";

  config = lib.mkIf cfg.enable {
    services.flatpak = {
      enable = true;

      update.auto = {
        enable = true;
        onCalendar = "daily";
      };

      packages = flatpaks;

      remotes = [
        {
          name = "flathub";
          location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
        }
      ];

      # -- clean up
      uninstallUnmanaged = true;
    };

    # -- network workaround
    systemd.services."flatpak-managed-install".unitConfig = {
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
  };
}
