{ pkgs, ... }:

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

    userSettings = builtins.fromJSON (
      builtins.readFile ./settings.jsonc
    );
  };
}
