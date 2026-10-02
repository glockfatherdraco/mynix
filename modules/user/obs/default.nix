{ config, lib, pkgs, dataDir, ... }:

let
  cfg = config.userSettings.obs;
  data = dataDir + "/obs";

  substituteHome = src: pkgs.replaceVars src { homeDir = config.home.homeDirectory; };

  basicIni = substituteHome (data + "/basic.ini");

  configFiles = {
    "global.ini" = data + "/global.ini";
    "user.ini" = data + "/user.ini";
    "basic/profiles/default/basic.ini" = basicIni;
    "basic/profiles/default/recordEncoder.json" = data + "/recordEncoder.json";
    "basic/scenes/main_scenes.json" = data + "/main_scenes.json";
  };

  copyBlock = lib.concatStringsSep "\n\n" (
    lib.mapAttrsToList (
      dest: src: ''
        target="$HOME/.config/obs-studio/${dest}"
        mkdir -p "$(dirname "$target")"
        [ -e "$target" ] || cp ${src} "$target"
      ''
    ) configFiles
  );
in
{
  options.userSettings.obs.enable = lib.mkEnableOption "obs Studio";

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;

      plugins = [
        pkgs.obs-studio-plugins.obs-vaapi
        pkgs.obs-studio-plugins.obs-gstreamer
        pkgs.obs-studio-plugins.obs-vkcapture
      ];
    };

    home.activation.obsConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] copyBlock;
  };
}
