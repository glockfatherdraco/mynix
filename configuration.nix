{
  # System settings
  system = {
    arch = "x86_64-linux";
    hostname = "nix";
    version = "26.05";
    timezone = "Europe/Vienna";
    locale = "en_US.UTF-8";
    dotfilesDir = "/etc/nixos";
  };

  # User settings
  user = {
    username = "gfd";
    name = "GFD";
  };

  # DNS servers
  dns = [
    "1.1.1.1#cloudflare-dns.com"
    "1.0.0.1#cloudflare-dns.com"
    "8.8.8.8#dns.google"
    "8.8.4.4#dns.google"
  ];

  # Git settings
  git = {
    username = "glockfatherdraco";
    email = "161503241+glockfatherdraco@users.noreply.github.com";
    signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcpyUZp7xVBVdMAF7CR71vaxpNSuQ9Xusgc8LXGFjIk";
    defaultBranch = "main";
    sshHosts = [
      "github.com"
      "gitlab.com"
      "codeberg.org"
    ];
  };

  # Home Manager packages
  packages = pkgs: [
    pkgs.wget
    pkgs.whois
    pkgs.yt-dlp

    pkgs.audacity
    pkgs.onlyoffice-desktopeditors
    pkgs.papers

    pkgs.adwaita-fonts
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # System modules
  systemSettings = {
    desktop = "cosmic";

    gaming.enable = true;
    printing.enable = false;
    flatpak = {
      enable = true;
      packages = [ "space.bigrat.mocktail" ];
    };
    bluetooth.enable = true;
    localsend.enable = true;

    security = {
      automount.enable = true;
      firewall.enable = true;
      firejail.enable = true;
    };
  };

  # User modules
  userSettings = {
    shell.enable = true;
    fastfetch.enable = true;
    git.enable = true;
    xdg.enable = true;

    bitwarden.enable = true;
    librewolf.enable = true;
    mpv.enable = true;
    nixcord.enable = true;
    obs.enable = true;
    thunderbird.enable = true;
    zed.enable = true;
  };
}
