{ pkgs, user, ... }:

{
  programs.fish.enable = true;
  users.users.${user.username}.shell = pkgs.fish;
}
