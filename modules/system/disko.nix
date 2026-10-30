{ system, lib, ... }:

let
  # -- shared btrfs options
  opts = [ "noatime" "compress=zstd" "discard=async" ];

  sub = mountpoint: {
    inherit mountpoint;
    mountOptions = opts;
  };
in
{
  disko.devices.disk.main = {
    type = "disk";
    device = lib.mkDefault system.disk;

    content = {
      type = "gpt";
      partitions = {
        # -- esp
        ESP = {
          label = "EFI";
          type = "EF00";
          size = "1G";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        # -- encryption settings
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
                "/root" = sub "/";
                "/nix" = sub "/nix";
                "/home" = sub "/home";
              };
            };
          };
        };
      };
    };
  };
}
