{ host, ... }:

let
  localsend = [ 53317 ];
in
{
  networking = {
    hostName = host;
    nftables.enable = true;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.macAddress = "random";
    };

    firewall = {
      allowedTCPPorts = localsend;
      allowedUDPPorts = localsend;
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1#cloudflare-dns.com"
        "1.0.0.1#cloudflare-dns.com"
        "8.8.8.8#dns.google"
        "8.8.4.4#dns.google"
      ];
      DNSOverTLS = "yes";
      DNSSEC = "allow-downgrade";
      Domains = [ "~." ];
      LLMNR = "false";
    };
  };
}
