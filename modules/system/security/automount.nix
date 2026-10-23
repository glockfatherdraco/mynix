{ config, lib, ... }:

let
  cfg = config.sysmods.automount;
in
{
  options.sysmods.automount.enable = lib.mkEnableOption "drive automount";

  # -- gvfs plus udisks
  config = lib.mkIf cfg.enable {
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
