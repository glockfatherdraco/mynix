{ config, lib, system, ... }:

{
  config = lib.mkIf (config.usrmods.terminal == "kitty") {
    home.sessionVariables.TERMINAL = "kitty";

    programs.kitty = {
      enable = true;

      font = {
        name = system.font;
        size = 12;
      };

      settings = {
        background_opacity = "0.80";
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        cursor_shape = "block";
        shell_integration = "no-cursor";
      };
    };
  };
}
