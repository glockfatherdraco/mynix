{ lib, user, sysmods, ... }:

let
  scan = dir: lib.filter
    (file: lib.hasSuffix ".nix" (toString file))
    (lib.filesystem.listFilesRecursive dir);
in
{
  imports = scan ./system;

  config = {
    inherit sysmods;

    home-manager.users.${user.username}.imports = scan ./user;
  };
}
