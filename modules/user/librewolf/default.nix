{ config, lib, pkgs, dataDir, ... }:

let
  cfg = config.userSettings.librewolf;
  data = dataDir + "/librewolf";

  librewolfPreferences = {
    "accessibility.force_disabled" = 1;
    "browser.aboutConfig.showWarning" = false;
    "browser.bookmarks.addedImportButton" = false;
    "browser.migrate.bookmarks-file.enabled" = false;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.toolbars.bookmarks.visibility" = "newtab";
    "browser.translations.neverTranslateLanguages" = "en";
    "dom.text_fragments.create_text_fragment.enabled" = true;
    "extensions.install_origins.enabled" = true;
    "general.autoScroll" = true;
    "gfx.canvas.accelerated" = true;
    "middlemouse.paste" = false;
    "network.dns.disablePrefetch" = true;
    "network.prefetch-next" = false;
    "privacy.clearOnShutdown_v2.cache" = false;
    "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
    "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
    "privacy.clearOnShutdown_v2.siteSettings" = false;
    "privacy.fingerprintingProtection" = true;
    "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme,-JSDateTimeUTC";
    "privacy.resistFingerprinting" = false;
    "webgl.disabled" = false;
  };

  formattedPrefs = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: value: "pref(\"${name}\", ${builtins.toJSON value});") librewolfPreferences
  );

  combinedPolicies = lib.recursiveUpdate
    (import (data + "/settings.nix"))
    {
      Bookmarks = import (data + "/bookmarks.nix");
      ExtensionSettings = import (data + "/extensions.nix");
      Cookies.Allow = [
        "https://discord.com"
      ];
    };

  librewolf-custom = pkgs.librewolf.override {
    extraPrefs = formattedPrefs;
    extraPolicies = combinedPolicies;
  };
in
{
  options.userSettings.librewolf.enable = lib.mkEnableOption "librewolf browser";

  config = lib.mkIf cfg.enable {
    home.packages = [ librewolf-custom ];
  };
}
