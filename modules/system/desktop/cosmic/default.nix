{
  config,
  lib,
  pkgs,
  ...
}:

lib.mkIf (config.systemSettings.desktop == "cosmic") {
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    system76-scheduler.enable = true;
  };

  # Exclude
  environment.cosmic.excludePackages = [
    pkgs.cosmic-store
    pkgs.cosmic-edit
    pkgs.cosmic-reader
    pkgs.cosmic-player
  ];
}
