{
  programs.nixcord.config.plugins = {
    alwaysExpandRoles.enable = true;
    alwaysTrust.enable = true;
    betterRoleContext.enable = true;
    betterRoleDot.enable = true;
    betterSettings.enable = true;
    betterUploadButton.enable = true;
    biggerStreamPreview.enable = true;
    clearUrls.enable = true;
    copyStickerLinks.enable = true;
    copyUserUrls.enable = true;
    disableCallIdle.enable = true;
    expressionCloner.enable = true;
    fakeNitro.enable = true;
    favoriteEmojiFirst.enable = true;
    forceOwnerCrown.enable = true;
    fullSearchContext.enable = true;
    fullUserInChatbox.enable = true;
    mutualGroupDms.enable = true;
    noMiddleClickPaste.enable = true;
    noOnboardingDelay.enable = true;
    noProfileThemes.enable = true;
    noReplyMention.enable = true;
    noTypingAnimation.enable = true;
    noUnblockToJump.enable = true;
    permissionsViewer.enable = true;
    plainFolderIcon.enable = true;
    platformIndicators.enable = true;
    quickMention.enable = true;
    readAllNotificationsButton.enable = true;
    reverseImageSearch.enable = true;
    reviewDb.enable = true;
    serverInfo.enable = true;
    showTimeoutDuration.enable = true;
    silentMessageToggle.enable = true;
    tenorGifSearch.enable = true;
    validReply.enable = true;
    validUser.enable = true;
    voiceChatDoubleClick.enable = true;
    voiceDownload.enable = true;
    webScreenShareFixes.enable = true;

    anonymiseFileNames = {
      enable = true;
      method = 1;
      consistent = "attachment";
    };

    clientTheme = {
      enable = true;
      color = "1B1B1B";
    };

    crashHandler = {
      enable = true;
      attemptToNavigateToHome = true;
      attemptToPreventCrashes = true;
    };

    customIdle = {
      enable = true;
      idleTimeout = 0.0;
      remainInIdle = true;
    };

    mentionAvatars = {
      enable = true;
      showAtSymbol = true;
    };

    notificationVolume = {
      enable = true;
      notificationVolume = 25.0;
    };

    relationshipNotifier = {
      enable = true;
      notices = true;
    };

    showHiddenThings = {
      enable = true;
      showInvitesPaused = true;
      showModView = true;
      showTimeouts = true;
    };

    silentTyping = {
      enable = true;
      isEnabled = true;
      showIcon = true;
    };

    voiceMessages = {
      enable = true;
      echoCancellation = false;
      noiseSuppression = false;
    };
  };
}
