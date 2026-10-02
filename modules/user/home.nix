{ pkgs, user, system, packages, ... }:

{
  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    stateVersion = system.version;
    packages = packages pkgs;
  };

  programs.home-manager.enable = true;
}
