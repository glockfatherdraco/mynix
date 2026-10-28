# /etc/nixos/home/nixcord.nix
{ ... }:
{
  programs.nixcord = {
    enable = true;

    discord = {
      enable = true;
      vencord.enable = true;
      openASAR.enable = true;
      krisp.enable = false;

      settings = {
        enableHardwareAcceleration = false;
        offloadAdmControls = true;
        openH264Enabled = true;
        openasar = {
          quickstart = true;
          setup = true;
        };
      };
    };

    config = {
      useQuickCss = false;
      plugins = {

        # -- qol
        betterGifPicker.enable = true;
        betterRoleContext.enable = true;
        betterRoleDot.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        clearUrls.enable = true;
        copyStickerLinks.enable = true;
        friendInvites.enable = true;
        fullSearchContext.enable = true;
        mutualGroupDms.enable = true;
        permissionsViewer.enable = true;
        platformIndicators.enable = true;
        relationshipNotifier = {
          enable = true;
          notices = true;
        };
        reverseImageSearch.enable = true;
        reviewDb.enable = true;
        serverInfo.enable = true;
        silentTyping.enable = true;
        validReply.enable = true;
        validUser.enable = true;

        # -- utils
        alwaysTrust.enable = true;
        copyUserUrls.enable = true;
        crashHandler.enable = true;
        customIdle = {
          enable = true;
          idleTimeout = 0.0;
        };
        directFileDownload.enable = true;
        disableCallIdle.enable = true;
        expressionCloner.enable = true;
        fakeNitro.enable = true;
        newGuildSettings.enable = true;
        noTypingAnimation.enable = true;

        # -- voice
        voiceDownload.enable = true;
        voiceMessages.enable = true;
      };
    };
  };
}
