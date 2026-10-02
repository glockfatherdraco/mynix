{ config, lib, pkgs, dataDir, ... }:

let
  cfg = config.userSettings.zed;

  zedSettings = builtins.fromJSON (
    builtins.readFile (dataDir + "/zed/settings.jsonc")
  );
in
{
  options.userSettings.zed.enable = lib.mkEnableOption "zed editor";

  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      defaultEditor = true;

      extensions = [
        "nix"
        "d2"
      ];

      extraPackages = [
        pkgs.nixd
        pkgs.clang-tools
        pkgs.clang
        pkgs.platformio
        pkgs.biome
      ];

      userSettings = zedSettings // {
        buffer_font_family = "JetBrainsMono Nerd Font";
      };
    };
  };
}
