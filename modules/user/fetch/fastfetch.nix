{ config, lib, settingsDir, ... }:

{
  config = lib.mkIf (config.usrmods.fetch == "fastfetch") {
    programs.fastfetch = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile (settingsDir + "/fastfetch/config.jsonc"));
    };

    programs.fish.interactiveShellInit = "fastfetch";
  };
}
