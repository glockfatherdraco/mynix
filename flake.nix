{
  description = "gfd-nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, nixcord, nix-flatpak, ... }:
    let
      cfg = import ./configuration.nix;
      inherit (cfg) system;
      dataDir = ./modules/data;

      shared = cfg // { inherit inputs dataDir; };
    in
    {
      nixosConfigurations.${system.hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = shared;

        modules = [
          { nixpkgs.hostPlatform = system.arch; }
          ./modules
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-bak";
              extraSpecialArgs = shared;
              sharedModules = [ nixcord.homeModules.nixcord ];
            };
          }
        ];
      };

      formatter.${system.arch} = nixpkgs.legacyPackages.${system.arch}.nixfmt;
    };
}
