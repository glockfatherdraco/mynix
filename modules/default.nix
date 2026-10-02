{ lib, user, systemSettings, userSettings, ... }:

let
  hardwareConfiguration = lib.optional (builtins.pathExists ../hardware-configuration.nix) ../hardware-configuration.nix;
  systemModules = lib.fileset.toList (
    lib.fileset.fileFilter (file: file.hasExt "nix") ./system
  );
  userModules = lib.fileset.toList (
    lib.fileset.fileFilter (file: file.hasExt "nix") ./user
  );
in
{
  imports = hardwareConfiguration ++ systemModules;

  config = {
    inherit systemSettings;
    home-manager.users.${user.username} = {
      inherit userSettings;
      imports = userModules;
    };
  };
}
