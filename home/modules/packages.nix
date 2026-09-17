{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Terminal Stuff
    wget
    whois

    # Applications
    audacity
    libreoffice
    localsend
    loupe # Until system76 makes cosmic viewer
    obs-studio
    papers
    prismlauncher
    proton-vpn
    protonplus
    r2modman
    yt-dlp

    # Fonts
    nerd-fonts._0xproto
  ];
}
