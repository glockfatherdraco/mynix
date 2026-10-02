{ config, lib, git, ... }:

let
  cfg = config.userSettings.git;
in
{
  options.userSettings.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      signing = {
        key = git.signingKey;
        signByDefault = true;
        format = "ssh";
      };

      settings = {
        user.name = git.username;
        user.email = git.email;

        init.defaultBranch = git.defaultBranch;

        url = lib.genAttrs
          (map (host: "ssh://git@${host}") git.sshHosts)
          (name: { insteadOf = "https://${lib.removePrefix "ssh://git@" name}"; });
      };
    };
  };
}
