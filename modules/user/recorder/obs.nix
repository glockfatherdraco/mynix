{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs; [
      obs-studio-plugins.obs-gstreamer
      obs-studio-plugins.obs-vkcapture
    ];
  };
}
