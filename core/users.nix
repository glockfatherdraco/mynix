{ pkgs, username, ... }:

{
  programs.fish.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "GFD"; # "Oh shit that's me"
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
