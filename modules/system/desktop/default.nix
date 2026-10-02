{ lib, ... }:

let
  desktopDirs = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./.)
  );
in
{
  options.systemSettings.desktop = lib.mkOption {
    type = lib.types.enum ([ "none" ] ++ desktopDirs);
    default = "none";
    description = ''
      Which desktop environment to run.
      "none" starts the system with no desktop.
    '';
  };
}
