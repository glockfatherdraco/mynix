{ config, lib, ... }:

let
  cfg = config.systemSettings.localsend;
in
{
  options.systemSettings.localsend.enable = lib.mkEnableOption "localSend";

  config = lib.mkIf cfg.enable {
    programs.localsend.enable = true;
    programs.localsend.openFirewall = true;
  };
}
