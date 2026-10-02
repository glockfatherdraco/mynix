{
  hardware.enableRedistributableFirmware = true;
  zramSwap.enable = true;

  services = {
    fstrim.enable = true;
    fwupd.enable = true;
  };
}
