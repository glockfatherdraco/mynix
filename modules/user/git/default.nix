{ git, lib, ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = git.key;
      signByDefault = true;
      format = "ssh";
    };

    settings = {
      user.name = git.username;
      user.email = git.email;

      init.defaultBranch = git.branch;

      url = lib.genAttrs (map (host: "ssh://git@${host}") git.hosts) (name: {
        insteadOf = "https://${lib.removePrefix "ssh://git@" name}";
      });
    };
  };
}
