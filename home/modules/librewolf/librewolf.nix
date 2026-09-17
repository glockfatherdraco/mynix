{
  pkgs,
  lib,
  config,
  ...
}:

let
  bookmarks = import ../../data/librewolf/bookmarks.nix;
  cfg = config.programs.librewolf-wrapper;
  extensions = import ../../data/librewolf/extensions.nix // cfg.extraExtensions;
  settings = import ../../data/librewolf/settings.nix;

  librewolfPackage = pkgs.wrapFirefox pkgs.librewolf-unwrapped {
    inherit (pkgs.librewolf-unwrapped)
      extraPrefsFiles
      extraPoliciesFiles;

    wmClass = "LibreWolf";
    libName = "librewolf";

    inherit (cfg) nativeMessagingHosts;
    # sudo opsec
    extraPrefs = /* javascript */ ''
      pref("accessibility.force_disabled", 1);
      pref("browser.aboutConfig.showWarning", false);
      pref("browser.bookmarks.addedImportButton", false);
      pref("browser.migrate.bookmarks-file.enabled", false);
      pref("browser.shell.checkDefaultBrowser", false);
      pref("browser.tabs.insertAfterCurrent", false);
      pref("browser.tabs.insertRelatedAfterCurrent", true);
      pref("browser.toolbars.bookmarks.visibility", "newtab");
      pref("browser.translations.neverTranslateLanguages", "fr");
      pref("dom.text_fragments.create_text_fragment.enabled", true);
      pref("extensions.autoDisableScopes", 0);
      pref("extensions.install_origins.enabled", true);
      pref("general.autoScroll", true);
      pref("gfx.canvas.accelerated", true);
      pref("gfx.webrender.enabled", true);
      pref("middlemouse.paste", false);
      pref("webgl.disabled", false);
      pref("privacy.clearOnShutdown_v2.cache", false);
      pref("privacy.clearOnShutdown_v2.cookiesAndStorage", false);
      pref("privacy.clearOnShutdown_v2.historyFormDataAndDownloads", false);
      pref("privacy.clearOnShutdown_v2.siteSettings", false);
      pref("privacy.resistFingerprinting", false);
      pref("privacy.fingerprintingProtection", true);
      pref("privacy.fingerprintingProtection.overrides", "+allTargets,-CSSPrefersColorScheme,-JSDateTimeUTC");
    '';

    extraPolicies = {
      Bookmarks = bookmarks;
      ExtensionSettings = extensions;

      Cookies = {
        Allow = [
          "https://discord.com"
        ];
      };

      EnableTrackingProtection = {
        Exceptions = [];
      };
    } // settings;
  };
in
{
  options.programs.librewolf-wrapper = {
    enable = (lib.mkEnableOption "the custom LibreWolf wrapper") // { default = true; };

    extraExtensions = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Additional LibreWolf/Firefox extensions to install.";
    };

    nativeMessagingHosts = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Native messaging hosts made available to LibreWolf extensions.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ librewolfPackage ];
  };
}
