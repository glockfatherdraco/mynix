{ pkgs, user, ... }:

{
  programs.fish.enable = true;
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.name;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
