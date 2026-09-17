{ ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBoPlEmDxfm1Q3Rx4PcZVPVcpqFpLaT45kRBlowfr3aN 161503241+glockfatherdraco@users.noreply.github.com";
      signByDefault = true;
      format = "ssh";
    };

    settings = {
      user = {
        name = "glockfatherdraco";
        email = "161503241+glockfatherdraco@users.noreply.github.com";
      };

      init.defaultBranch = "main";

      url = {
        "ssh://git@github.com".insteadOf = "https://github.com";
        "ssh://git@codeberg.org".insteadOf = "https://codeberg.org";
      };
    };
  };
}
