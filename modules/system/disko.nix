{ system, lib, ... }:
{
  disko.devices.disk.main = {
    type = "disk";
    device = lib.mkDefault system.disk;

    content = {
      type = "gpt";
      partitions = {
        ESP = {
          label = "EFI";
          type = "EF00";
          size = "1G";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "dmask=0077" ];
          };
        };

        root = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypted";
            settings = {
              allowDiscards = true;
              bypassWorkqueues = true;
              crypttabExtraOpts = [ "tpm2-device=auto" ];
            };
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "noatime"
                    "compress=zstd"
                    "discard=async"
                  ];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "noatime"
                    "compress=zstd"
                    "discard=async"
                  ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "noatime"
                    "compress=zstd"
                    "discard=async"
                  ];
                };
                "/boot" = {
                  mountpoint = "/boot";
                  mountOptions = [
                    "noatime"
                    "compress=zstd"
                    "discard=async"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
