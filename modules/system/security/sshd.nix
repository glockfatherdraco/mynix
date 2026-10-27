{ git, user, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  users.users.${user.username}.openssh.authorizedKeys.keys = [ git.key ];
}
