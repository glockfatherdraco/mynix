{ config, lib, dataDir, ... }:

let
  cfg = config.userSettings.fastfetch;
in
{
  options.userSettings.fastfetch.enable = lib.mkEnableOption "fastfetch";

  config = lib.mkIf cfg.enable {
    programs.fastfetch.enable = true;

    xdg.configFile."fastfetch/config.jsonc".source = dataDir + "/fastfetch/config.jsonc";
  };
}
