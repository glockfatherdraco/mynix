{ system, lib, ... }:
{
  disko.devices.disk.main = {
    type = "disk";
    device = lib.mkDefault system.disk;

    content = {
      type = "gpt";
      partitions = {
        ESP = {
          priority = 1;
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

        root = {
          priority = 2;
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
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [ "noatime" ];
            };
          };
        };
      };
    };
  };
}
