{ pkgs, config, lib, ... }:

lib.mkIf (config.systemSettings.desktop == "gnome") {
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # The fucking Desktop
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # X11 compatibility
  programs.xwayland.enable = true;

  # Exclude
  environment.gnome.excludePackages = [
    pkgs.baobab
    pkgs.epiphany
    pkgs.evince
    pkgs.geary
    pkgs.gnome-backgrounds
    pkgs.gnome-calculator
    pkgs.gnome-calendar
    pkgs.gnome-characters
    pkgs.gnome-console
    pkgs.gnome-contacts
    pkgs.gnome-disk-utility
    pkgs.gnome-font-viewer
    pkgs.gnome-logs
    pkgs.gnome-maps
    pkgs.gnome-music
    pkgs.gnome-software
    pkgs.gnome-text-editor
    pkgs.gnome-tour
    pkgs.gnome-user-docs
    pkgs.gnome-weather
    pkgs.gnome-connections
    pkgs.orca
    pkgs.simple-scan
    pkgs.snapshot
    pkgs.totem
    pkgs.yelp
  ];
}
