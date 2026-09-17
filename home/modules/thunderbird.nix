{
  programs.thunderbird = {
    enable = true;

    policies = {
      ExtensionSettings = {
        # TbSync
        "farahats9@yahoo.com" = {
          install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/tbsync/addon-tbsync-latest.xpi";
          installation_mode = "force_installed";
        };

        # DKIM Verifier
        "dkim_verifier@pl" = {
          install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/dkim-verifier/addon-dkim-verifier-latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.default = {
      isDefault = true;

      settings = {
        # UI
        "mailnews.start_page.enabled" = false;
        "mail.receipt.request_return_receipt_on" = true;
        "mail.SpellCheckBeforeSend" = true;

        # Privacy Stuff
        "network.cookie.cookieBehavior" = 1;
        "privacy.globalprivacycontrol.enabled" = true;

        # Telemetry
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
      };
    };
  };
}
