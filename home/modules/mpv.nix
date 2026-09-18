{ pkgs, ... }:

{
  programs.mpv = {
    config = {
      # Rendering
      vo = "gpu-next";
      gpu-context = "wayland";
      hwdec = "auto";
      profile = "high-quality";

      # OSC config
      osc = false;
      osd-bar = false;

      # yt-dlp
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      ytdl-raw-options = "ignore-config=,embed-chapters=";
    };

    enable = true;
    scripts = with pkgs.mpvScripts; [
      mpv-osc-modern
      thumbfast
    ];
  };
}
