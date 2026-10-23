{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.usrmods.terminal == "cosmic-term") {
    home.sessionVariables.TERMINAL = "cosmic-term";
    home.packages = [ pkgs.cosmic-term ];
  };
}
