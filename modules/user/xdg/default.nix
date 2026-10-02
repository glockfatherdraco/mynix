{ config, lib, ... }:

let
  cfg = config.userSettings.xdg;
in
{
  options.userSettings.xdg.enable = lib.mkEnableOption "my xdg directories";

  config = lib.mkIf cfg.enable {
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps.enable = true;

      userDirs = {
        enable = true;
        createDirectories = true;

        desktop = "${config.home.homeDirectory}/Desktop";
        documents = "${config.home.homeDirectory}/Documents";
        download = "${config.home.homeDirectory}/Downloads";
        music = "${config.home.homeDirectory}/Music";
        pictures = "${config.home.homeDirectory}/Pictures";
        videos = "${config.home.homeDirectory}/Videos";

        # Not used
        projects = null;
        publicShare = null;
        templates = null;

        extraConfig = {
          XDG_RECORDINGS_DIR = "${config.home.homeDirectory}/Videos/Recordings";
          XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
          XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Documents/Projects";
        };
      };
    };
  };
}
