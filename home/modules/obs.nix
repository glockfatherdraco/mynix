{ pkgs, lib, config, username, ... }:

let
  data = ../data/obs;
  substHome = builtins.replaceStrings
    [ "/home/${username}" ]
    [ config.home.homeDirectory ];

  globalIni = pkgs.writeText "obs-global.ini"
    (substHome (builtins.readFile (data + "/global.ini")));

  basicIni = pkgs.writeText "obs-basic.ini"
    (substHome (builtins.readFile (data + "/basic.ini")));
in
{
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-vkcapture
    ];
  };

  home.activation.obsConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/obs-studio/basic/profiles/default"
    mkdir -p "$HOME/.config/obs-studio/basic/scenes"

    [ -e "$HOME/.config/obs-studio/global.ini" ] ||
      cp ${globalIni} "$HOME/.config/obs-studio/global.ini"

    [ -e "$HOME/.config/obs-studio/basic/profiles/default/basic.ini" ] ||
      cp ${basicIni} "$HOME/.config/obs-studio/basic/profiles/default/basic.ini"

    [ -e "$HOME/.config/obs-studio/user.ini" ] ||
      cp ${data}/user.ini "$HOME/.config/obs-studio/user.ini"

    [ -e "$HOME/.config/obs-studio/basic/profiles/default/recordEncoder.json" ] ||
      cp ${data}/recordEncoder.json "$HOME/.config/obs-studio/basic/profiles/default/recordEncoder.json"

    [ -e "$HOME/.config/obs-studio/basic/scenes/main_scenes.json" ] ||
      cp ${data}/main_scenes.json "$HOME/.config/obs-studio/basic/scenes/main_scenes.json"
  '';
}
