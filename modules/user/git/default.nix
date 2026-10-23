{ config, lib, ... }:

let
  cfg = config.usrmods.git;
in
{
  options.usrmods.git = {
    enable = lib.mkEnableOption "git";

    branch = lib.mkOption {
      type = lib.types.str;
      default = "main";
      description = "default branch name for repos";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "commit email address";
    };

    key = lib.mkOption {
      type = lib.types.str;
      description = "SSH public key";
    };

    username = lib.mkOption {
      type = lib.types.str;
      description = "commit author name";
    };

    hosts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "hosts to rewrite from https:// to ssh://";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      signing = {
        key = cfg.key;
        signByDefault = true;
        format = "ssh";
      };

      settings = {
        user.name = cfg.username;
        user.email = cfg.email;

        init.defaultBranch = cfg.branch;

        url = lib.genAttrs (map (host: "ssh://git@${host}") cfg.hosts) (name: {
          insteadOf = "https://${lib.removePrefix "ssh://git@" name}";
        });
      };
    };
  };
}
