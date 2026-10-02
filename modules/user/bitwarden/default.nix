{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.bitwarden;
  sshSock = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
in
{
  options.userSettings.bitwarden.enable = lib.mkEnableOption "bitwarden password manager";

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.bitwarden-desktop ];
    home.sessionVariables.SSH_AUTH_SOCK = lib.mkForce sshSock;
    systemd.user.sessionVariables.SSH_AUTH_SOCK = lib.mkForce sshSock;
  };
}
