{ system, lib, ... }:
let
  espMountOptions = [
    "fmask=0077"
    "dmask=0077"
  ];
in
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
            mountOptions = espMountOptions;
          };
        };

        root = {
          size = "100%";
          content = {
            type = "luks";
            name = "crypted";
            passwordFile = "/tmp/disk.key";
            settings = {
              allowDiscards = true;
              bypassWorkqueues = true;
              crypttabExtraOpts = [ "tpm2-device=auto" ];
            };
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
