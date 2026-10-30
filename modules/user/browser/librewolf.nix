{ ... }:

let
  data = ../../../assets/librewolf;
in
{
  programs.librewolf = {
    enable = true;

    # -- my default profile
    profiles.home = {
      name = "home";
      isDefault = true;
      settings = import (data + "/prefs.nix");
    };

    # -- policies: settings, bookmarks and extensions
    policies = (import (data + "/settings.nix")) // {
      Bookmarks = import (data + "/bookmarks.nix");
      ExtensionSettings = import (data + "/extensions.nix");
      SearchEngines = import (data + "/search.nix");
    };
  };
}
