{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.usrmods.recorder == "obs") {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs; [
        obs-studio-plugins.obs-vaapi
        obs-studio-plugins.obs-gstreamer
        obs-studio-plugins.obs-vkcapture
      ];
    };
  };
}
