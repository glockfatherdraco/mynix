{
  # -- system settings
  system = {
    hostname = "nix";
    arch = "x86_64-linux";
    version = "26.05";
    locale = "en_US.UTF-8";
    timezone = "Europe/Vienna";
    font = "JetBrainsMono Nerd Font";
    dotfiles = "/etc/nixos";
    disk = "/dev/disk/by-id/nvme-CUSU_CV3500Q_512GB_70QL8A4Z25I2X0FZKJ3N";
    dns = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
    ];
  };

  # -- user settings
  user = {
    name = "GFD";
    username = "gfd";
  };

  # -- git settings
  git = {
    branch = "main";
    email = "161503241+glockfatherdraco@users.noreply.github.com";
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcpyUZp7xVBVdMAF7CR71vaxpNSuQ9Xusgc8LXGFjIk";
    username = "glockfatherdraco";
    hosts = [
      "codeberg.org"
      "github.com"
      "gitlab.com"
    ];
  };

  # -- optional system modules
  sysmods = {
    bluetooth.enable = false;
    gaming.enable = false;
    localsend.enable = true;
    printing.enable = false;
  };

  # -- flatpaks
  flatpaks = [
    "space.bigrat.mocktail"
  ];

  # -- packages
  packages =
    pkgs: with pkgs; [
      adwaita-fonts
      nerd-fonts.jetbrains-mono

      steamguard-cli
      yt-dlp


      onlyoffice-desktopeditors
      papers
      vesktop

    ];
}
