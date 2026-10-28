{ config, lib, pkgs, system, user, ... }:

{
  # -- nix
  nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [
        "https://nix-community.cachix.org"
        "https://nix-cache.tokidoki.dev/tokidoki"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "tokidoki:MD4VWt3kK8Fmz3jkiGoNRJIW31/QAm7l1Dcgz2Xa4hk="
      ];
    };
  };

  programs.nix-ld.enable = true;
  documentation.nixos.enable = false;
  system.stateVersion = system.version;

  # -- boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "tcp_bbr" ];

    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_fastopen" = 3;
    };

    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      configurationLimit = 4;
      autoGenerateKeys.enable = true;

      autoEnrollKeys = {
        enable = true;
        includeMicrosoftKeys = true;
        allowBrickingMyMachine = true;
      };

      measuredBoot = {
        enable = true;
        pcrs = [ 0 4 7 ];
        autoCryptenroll = {
          enable = true;
          device = config.disko.devices.disk.main.content.partitions.root.device;
        };
      };
    };
  };

  # -- hardware
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  zramSwap.enable = true;

  # -- security
  security = {
    tpm2.enable = true;
    sudo.execWheelOnly = true;
    rtkit.enable = true; # pipewire lowkey needs it
  };

  environment.systemPackages = [ pkgs.sbctl ];

  # -- networking
  networking = {
    hostName = system.hostname;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.macAddress = "random";
    };
  };

  # -- services
  services = {
    fstrim.enable = true;
    fwupd.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    resolved = {
      enable = true;
      settings.Resolve = {
        DNS = system.dns;
        DNSOverTLS = "true";
        DNSSEC = "allow-downgrade";
        Domains = [ "~." ];
        LLMNR = "false";
      };
    };
  };

  # -- locale
  time.timeZone = system.timezone;

  i18n = {
    defaultLocale = system.locale;
    extraLocaleSettings = lib.genAttrs [
      "LC_ADDRESS"
      "LC_IDENTIFICATION"
      "LC_MEASUREMENT"
      "LC_MONETARY"
      "LC_NAME"
      "LC_NUMERIC"
      "LC_PAPER"
      "LC_TELEPHONE"
      "LC_TIME"
    ] (_: system.locale);
  };

  # -- users
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.name;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
