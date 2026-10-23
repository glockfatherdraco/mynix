{ config, lib, ... }:

let
  cfg = config.sysmods.printing;
in
{
  options.sysmods.printing.enable = lib.mkEnableOption "printing";

  config = lib.mkIf cfg.enable {
    services.printing.enable = true;

    # automatic discovery for network printers
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
