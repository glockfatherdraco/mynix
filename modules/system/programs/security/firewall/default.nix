{ config, lib, ... }:

let
  cfg = config.systemSettings.security.firewall;
in
{
  options.systemSettings.security.firewall.enable = lib.mkEnableOption "the firewall";

  config = {
    networking.firewall.enable = cfg.enable;
    networking.nftables.enable = cfg.enable;
  };
}
