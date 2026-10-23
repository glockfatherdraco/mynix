{ lib, user, sysmods, usrmods, ... }:

let
  inherit (builtins) readDir;

  nixFilesIn = dir: lib.filter (lib.hasSuffix ".nix") (lib.filesystem.listFilesRecursive dir);
  namesIn = dir: map (file: lib.removeSuffix ".nix" (baseNameOf file)) (nixFilesIn dir);

  userChoiceDirs = lib.subtractLists [ "git" "shell" ] (
    lib.attrNames (lib.filterAttrs (_: type: type == "directory") (readDir ./user))
  );

  userChoices = lib.genAttrs userChoiceDirs (
    category:
    let
      names = namesIn (./user + "/${category}");
    in
    lib.mkOption {
      type = lib.types.nullOr (lib.types.enum names);
      default = null;
      description = "Which ${category} to use (one of: ${lib.concatStringsSep ", " names}); null disables it.";
    }
  );
in
{
  # host.nix is flake-parts wiring, not a module.
  imports = lib.subtractLists [ ./system/host.nix ] (nixFilesIn ./system);

  config = {
    inherit sysmods;
    home-manager.users.${user.username} = {
      imports = nixFilesIn ./user;
      options.usrmods = userChoices;
      config.usrmods = usrmods;
    };
  };
}
