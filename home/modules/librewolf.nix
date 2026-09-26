{ lib, config, ... }:

let
  cfg = config.programs.librewolf-wrapper;
  data = ../data/librewolf;
in
{
  options.programs.librewolf-wrapper = {
    enable = lib.mkEnableOption "the custom LibreWolf wrapper" // {
      default = true;
    };

    extraExtensions = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Additional LibreWolf/Firefox extensions to install.";
    };

    nativeMessagingHosts = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Native messaging hosts made available to LibreWolf extensions.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      inherit (cfg) nativeMessagingHosts;

      settings = import (data + "/prefs.nix");

      policies = lib.recursiveUpdate
        {
          Bookmarks = import (data + "/bookmarks.nix");
          ExtensionSettings =
            import (data + "/extensions.nix")
            // cfg.extraExtensions;
          Cookies.Allow = [
            "https://discord.com"
          ];
        }
        (import (data + "/settings.nix"));
    };
  };
}
