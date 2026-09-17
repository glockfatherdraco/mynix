{ pkgs, ... }:

{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    system76-scheduler.enable = true;
  };

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
    cosmic-edit
    cosmic-reader
    cosmic-player
  ];
}
