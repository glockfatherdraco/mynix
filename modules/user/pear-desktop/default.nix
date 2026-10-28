{
  programs.pear-desktop = {
    enable = true;

    options = {
      tray = true;
      startingPage = "Library";
    };

    plugins = {
      disable-autoplay = {
        enable = true;
        applyOnce = true;
      };
      crossfade.enable = true;

      # -- ui tweaks
      in-app-menu.enable = true;
      compact-sidebar.enable = true;
      blur-nav-bar.enable = true;

      # -- adblock cause google's evil
      do-not-track.enable = true;
      sponsorblock.enable = true;

      # -- integrations (discord and lastFM)
      discord.enable = true;
      synced-lyrics.enable = true;
      scrobbler = {
        enable = true;
        scrobblers.lastfm.enable = true;
      };
    };
  };
}
