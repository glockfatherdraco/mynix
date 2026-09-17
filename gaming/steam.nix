{ pkgs, ... }:

{
  programs.steam = {
    enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Firewall
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;

    # Wayland Input Thing
    extest.enable = true;

    # Proton winetricks
    protontricks.enable = true;
  };
}
