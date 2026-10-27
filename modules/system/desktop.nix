{ pkgs, ... }:

{
  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
    system76-scheduler.enable = true;
  };

  # -- exclude
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
    cosmic-edit
    cosmic-reader
    cosmic-player
  ];
}
