{ config, lib, ... }:

let
  cfg = config.sysmods.localsend;
in
{
  options.sysmods.localsend.enable = lib.mkEnableOption "localsend";

  config = lib.mkIf cfg.enable {
    programs.localsend.enable = true;
    programs.localsend.openFirewall = true;
  };
}
