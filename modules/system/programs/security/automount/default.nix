{ config, lib, ... }:

let
  cfg = config.systemSettings.security.automount;
in
{
  options.systemSettings.security.automount.enable = lib.mkEnableOption "automount for removable media";

  config = lib.mkIf cfg.enable {
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
