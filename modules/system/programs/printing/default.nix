{ config, lib, ... }:

let
  cfg = config.systemSettings.printing;
in
{
  options.systemSettings.printing.enable = lib.mkEnableOption "printing";

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;

    # Automatic discovery for network printers
    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };
  };
}
