{
  programs.fastfetch = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ../../../assets/fastfetch/config.jsonc);
  };

  programs.fish.interactiveShellInit = "fastfetch";
}
