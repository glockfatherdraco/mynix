{
  programs.nixcord = {
    discord.enable = false;
    enable = true;

    # vencoh
    vesktop = {
      enable = true;
      settings = {
        disableSmoothScroll = true;
        hardwareAcceleration = false;
        staticTitle = true;
        offloadAdmControls = true;
        openH264Enabled = true;
        debugLogging = false;
      };
    };
  };
}
