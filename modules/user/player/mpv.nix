{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.usrmods.player == "mpv") {
    programs.mpv = {
      enable = true;

      config = {
        vo = "gpu-next";
        gpu-context = "wayland";
        hwdec = "auto";
        osc = false;
        osd-bar = false;
      };

      defaultProfiles = [ "high-quality" ];

      scripts = with pkgs; [
        mpvScripts.mpv-osc-modern
        mpvScripts.thumbfast
      ];
    };
  };
}
