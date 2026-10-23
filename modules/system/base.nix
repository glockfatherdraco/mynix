{ lib, pkgs, modulesPath, system, user, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # -- boot
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "tcp_bbr" "kvm-amd" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_fastopen" = 3;
    };
    initrd = {
      systemd.enable = true;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
      ];
    };
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };

    # -- lanzabooty
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        includeMicrosoftKeys = true;
        allowBrickingMyMachine = true;
      };
      configurationLimit = 5;
    };
  };

  # -- hardware
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  zramSwap.enable = true;

  # -- tpm2
  security.tpm2.enable = true;

  # -- audio
  security.rtkit.enable = true;

  # -- networking
  networking = {
    hostName = system.hostname;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.macAddress = "random";
    };
  };

  # -- services (fstrim, fwupd, pipewire, resolved)
  services = {
    fstrim.enable = true;
    fwupd.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    resolved = {
      enable = true;
      settings.Resolve = {
        DNS = system.dns;
        DNSOverTLS = "yes";
        DNSSEC = "yes";
        Domains = [ "~." ];
        LLMNR = "false";
      };
    };
  };

  # -- locale
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
  time.timeZone = system.timezone;

  # -- nix
  nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false;

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  programs.nix-ld.enable = true;
  documentation.nixos.enable = false;
  system.stateVersion = system.version;

  # -- users
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.name;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
