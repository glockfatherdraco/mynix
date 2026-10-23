{ config, lib, pkgs, settingsDir, system, ... }:

let
  zedSettings = builtins.fromJSON (builtins.readFile (settingsDir + "/zed/settings.jsonc"));
in
{
  config = lib.mkIf (config.usrmods.editor == "zed") {
    programs.zed-editor = {
      enable = true;
      defaultEditor = true;

      # -- extensions
      extensions = [ "nix" ];

      # -- language servers
      extraPackages = with pkgs; [
        nixd
        clang-tools
        biome
        rust-analyzer
      ];

      userSettings = zedSettings // {
        buffer_font_family = system.font;
      };
    };
  };
}
