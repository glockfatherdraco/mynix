{ host, ... }:

{
  networking = {
    hostName = host;
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";

      wifi = {
        macAddress = "random";
        scanRandMacAddress = true;
      };
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 53317 ];
      allowedUDPPorts = [ 53317 ];
    };

    nftables.enable = true;

    nameservers = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
    ];
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = "yes";
      DNSSEC = "allow-downgrade";
      Domains = [ "~." ];
      FallbackDNS = [
        "8.8.8.8#dns.google"
        "8.8.4.4#dns.google"
      ];
    };
  };
}
