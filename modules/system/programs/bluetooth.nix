{ config, lib, ... }:

let
  cfg = config.sysmods.bluetooth;
in
{
  options.sysmods.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = {
    hardware.bluetooth.enable = cfg.enable;
  };
}
