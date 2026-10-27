{ pkgs, system, ... }:

let
  zedSettings = builtins.fromJSON (builtins.readFile ../../../assets/zed/settings.jsonc);
in
{
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
}
