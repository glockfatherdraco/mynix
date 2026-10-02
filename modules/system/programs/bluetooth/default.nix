{ lib, config, ... }:

let
  cfg = config.systemSettings.bluetooth;
in {
  options.systemSettings.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
