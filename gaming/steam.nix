{ pkgs, ... }:

{
  programs.steam = {
    enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    protontricks.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
