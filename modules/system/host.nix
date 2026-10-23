{ inputs, ... }:

let
  cfg = import ../../configuration.nix;
  inherit (cfg) system;
  settingsDir = ../settings;

  shared = cfg // {
    inherit inputs settingsDir;
  };
in
{
  systems = [ system.arch ];

  flake.nixosConfigurations.${system.hostname} = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = shared;

    modules = [
      { nixpkgs.hostPlatform = system.arch; }
      ../default.nix
      inputs.disko.nixosModules.disko
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.home-manager.nixosModules.home-manager
      inputs.nix-flatpak.nixosModules.nix-flatpak
      inputs.nix-index-database.nixosModules.default
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-bak";
          extraSpecialArgs = shared;
          sharedModules = [
            inputs.nix-index-database.homeModules.default
          ];
        };
      }
    ];
  };
}
