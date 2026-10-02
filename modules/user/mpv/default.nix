{ config, lib, pkgs, ... }:

let
  cfg = config.userSettings.mpv;
in
{
  options.userSettings.mpv.enable = lib.mkEnableOption "mpv media player";

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;

      config = {
        vo = "gpu-next";
        gpu-context = "wayland";
        hwdec = "auto";
        osc = false;
        osd-bar = false;
        ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
        ytdl-raw-options = "ignore-config=,embed-chapters=";
      };

      defaultProfiles = [ "high-quality" ];

      scripts = [
        pkgs.mpvScripts.mpv-osc-modern
        pkgs.mpvScripts.thumbfast
      ];
    };
  };
}
