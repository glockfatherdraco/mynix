{ config, lib, ... }:

let
  cfg = config.userSettings.thunderbird;
  mkExt = slug: {
    install_url = "https://addons.thunderbird.net/thunderbird/downloads/latest/${slug}/latest.xpi";
    installation_mode = "force_installed";
  };
in
{
  options.userSettings.thunderbird.enable = lib.mkEnableOption "thunderbird email client";

  config = lib.mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;

      policies = {
        DisableTelemetry = true;

        ExtensionSettings = {
          "dkim_verifier@pl" = mkExt "dkim-verifier";
          "uBlock0@raymondhill.net" = mkExt "ublock-origin";
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
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };
}
