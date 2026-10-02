{ system, dns, ... }:

{
  networking = {
    hostName = system.hostname;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.macAddress = "random";
    };
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = dns;
      DNSOverTLS = "yes";
      DNSSEC = "yes";
      Domains = [ "~." ];
      LLMNR = "false";
    };
  };
}
