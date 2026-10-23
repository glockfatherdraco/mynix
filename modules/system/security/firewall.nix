{ config, lib, ... }:

let
  cfg = config.sysmods.firewall;
in
{
  options.sysmods.firewall.enable = lib.mkEnableOption "firewall (nftables)";

  # -- firewall (nftables)
  config = {
    networking.firewall.enable = cfg.enable;
    networking.nftables.enable = cfg.enable;
  };
}
