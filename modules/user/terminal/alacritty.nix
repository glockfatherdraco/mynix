{ config, lib, system, ... }:

{
  config = lib.mkIf (config.usrmods.terminal == "alacritty") {
    home.sessionVariables.TERMINAL = "alacritty";

    programs.alacritty = {
      enable = true;

      settings = {
        window.opacity = 0.80;

        font = {
          size = 12;
          normal.family = system.font;
        };
      };
    };
  };
}
