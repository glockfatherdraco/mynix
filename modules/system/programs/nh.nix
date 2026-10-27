{ system, ... }:

{
  # -- settings
  programs.nh = {
    enable = true;
    flake = system.dotfiles;

    # -- garbage collector
    clean = {
      enable = true;
      extraArgs = "--optimise";
    };
  };

  # -- shell shortcuts
  environment.shellAliases = {
    rebuild = "nh os switch";
    upgrade = "nh os switch --update";
    rollback = "nh os rollback";
    gens = "nh os info";
    clean = "nh clean all --optimise";
  };
}
