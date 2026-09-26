{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal Stuff
    wget
    whois

    # Applications
    audacity
    godot-mono
    libreoffice
    localsend
    loupe # Until system76 makes cosmic viewer
    papers
    prismlauncher
    protonplus
    r2modman
    yt-dlp

    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
