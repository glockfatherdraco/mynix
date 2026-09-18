let
  mkExt = slug: {
    install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/${slug}/latest.xpi";
    installation_mode = "force_installed";
  };
in
{
  programs.thunderbird = {
    enable = true;

    policies = {
      DisableTelemetry = true;

      ExtensionSettings = {
        "tbsync@jobisoft.de" = mkExt "tbsync";
        "dkim_verifier@pl" = mkExt "dkim-verifier";
      };
    };

    profiles.default = {
      isDefault = true;

      settings = {
        "mailnews.start_page.enabled" = false;
        "mail.shell.checkDefaultClient" = false;
        "mail.SpellCheckBeforeSend" = true;
        "mail.mdn.report.enabled" = false;
        "network.cookie.cookieBehavior" = 1;
        "privacy.globalprivacycontrol.enabled" = true;
      };
    };
  };
}
