{ pkgs, system, packages, ... }:

{
  home = {
    stateVersion = system.version;
    packages = packages pkgs;
    sessionVariables.TERMINAL = "cosmic-term";
  };
}
