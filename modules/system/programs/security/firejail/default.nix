{
  config,
  lib,
  pkgs,
  dataDir,
  ...
}:

let
  cfg = config.systemSettings.security.firejail;
  profileDir = "${pkgs.firejail}/etc/firejail";
  apps = {
    steam = {
      executable = lib.getExe pkgs.steam;
      desktop = "${pkgs.steam}/share/applications/steam.desktop";
      profile = "${profileDir}/steam.profile";
    };
    steam-run = {
      executable = lib.getExe pkgs.steam-run;
      profile = "${profileDir}/steam.profile";
    };
    prismlauncher = {
      executable = lib.getExe pkgs.prismlauncher;
      desktop = "${pkgs.prismlauncher}/share/applications/org.prismlauncher.PrismLauncher.desktop";
      profile = "${dataDir}/firejail/prismlauncher.profile";
    };
  };
in
{
  options.systemSettings.security.firejail.enable = lib.mkEnableOption "firejail sandboxing";

  config = lib.mkIf cfg.enable {
    programs.firejail = {
      enable = true;
      wrappedBinaries = apps;
    };
  };
}
