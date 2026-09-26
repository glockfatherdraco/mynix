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
      "space.bigrat.mocktail" # Life is Roblox
    ];
  };

  # Makes Flatpak wait for a network connection before updating
  systemd.services."flatpak-managed-install".unitConfig = {
    After = [ "network-online.target" ];
    Wants = [ "network-online.target" ];
  };
}
