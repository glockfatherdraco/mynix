{ pkgs, ... }:

let
  zedSettings = builtins.fromJSON (
    builtins.readFile ../data/zed/settings.jsonc
  );
in
{
  programs.zed-editor = {
    enable = true;
    defaultEditor = true;

    extensions = [
      "nix"
      "d2"
    ];

    extraPackages = with pkgs; [
      nixd
      clang-tools
      clang
      platformio
      biome
    ];

    userSettings = zedSettings;
  };
}
