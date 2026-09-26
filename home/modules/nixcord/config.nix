{
  programs.nixcord = {
    enable = true;
    discord.enable = false;

    # Vencoh
    vesktop = {
      enable = true;
      settings = {
        hardwareAcceleration = false;
        staticTitle = true;
        offloadAdmControls = true;
        openH264Enabled = true;
        debugLogging = false;
      };
    };
  };
}
