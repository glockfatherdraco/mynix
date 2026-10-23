{ config, lib, ... }:

let
  cfg = config.sysmods.bluetooth;
in
{
  options.sysmods.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
