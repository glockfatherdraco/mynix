{ lib, username, ... }:

{
  imports = lib.fileset.toList (
    lib.fileset.fileFilter (file: file.hasExt "nix") ./modules
  );

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
}
