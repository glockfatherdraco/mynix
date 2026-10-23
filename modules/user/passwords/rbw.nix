{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.usrmods.passwords == "rbw") {
    programs.rbw.enable = true;
    home.packages = [ pkgs.pinentry-gnome3 ];
    programs.fish.interactiveShellInit = ''
      set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/rbw/ssh-agent-socket
    '';
  };
}
