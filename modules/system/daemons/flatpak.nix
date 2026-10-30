{ flatpaks, ... }:

{
  services.flatpak = {
    enable = true;
    packages = flatpaks;
    uninstallUnmanaged = true;

    update.auto = {
      enable = true;
      onCalendar = "daily";
    };

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
  };

  # -- waits for networkmanager service to go online
  systemd.services.flatpak-managed-install = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
  };
}
