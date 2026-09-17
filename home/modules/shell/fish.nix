{ host, username, ... }:

{
  # fih
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
    '';

    # Aliases
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#${host}";
      clean = "sudo nix-collect-garbage -d && sudo nix-store --optimise";
      sn = "sudo nano";
      home = "cd /home/${username}/";
      edit = "cd /etc/nixos";
      off = "sudo reboot";
      ff = "fastfetch";
      bh = "bash";
    };
  };
}
