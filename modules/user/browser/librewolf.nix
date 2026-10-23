{ config, lib, pkgs, settingsDir, ... }:

let
  data = settingsDir + "/librewolf";

  # -- preferences
  formattedPrefs = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: value: "pref(\"${name}\", ${builtins.toJSON value});") (
      import (data + "/prefs.nix")
    )
  );

  # -- settings, bookmarks and extensions
  combinedPolicies = lib.recursiveUpdate (import (data + "/settings.nix")) {
    Bookmarks = import (data + "/bookmarks.nix");
    ExtensionSettings = import (data + "/extensions.nix");
  };

  librewolf-custom = pkgs.librewolf.override {
    extraPrefs = formattedPrefs;
    extraPolicies = combinedPolicies;
  };
in
{
  config = lib.mkIf (config.usrmods.browser == "librewolf") {
    home.packages = [ librewolf-custom ];
  };
}
