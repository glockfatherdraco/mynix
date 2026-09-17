{
  services.flatpak = {
    enable = true;

    # Cleanup
    uninstallUnmanaged = true;
    uninstallUnused = true;

    # Automatic Updates
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };

    # Remotes
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    # Applications
    packages = [
      "com.usebottles.bottles"
      "space.bigrat.mocktail" # Life is Roblox
    ];
  };

  # Network workaround for declarative installs because Flatpak updates may
  # start before the network is online.
  systemd.services."flatpak-managed-install".unitConfig = {
    After = [ "network-online.target" ];
    Wants = [ "network-online.target" ];
  };
}
