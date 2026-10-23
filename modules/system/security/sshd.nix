{ config, lib, usrmods, user, ... }:

let
  cfg = config.sysmods.sshd;
in
{
  options.sysmods.sshd.enable = lib.mkEnableOption "openssh";

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    users.users.${user.username}.openssh.authorizedKeys.keys = [ usrmods.git.key ];
  };
}
