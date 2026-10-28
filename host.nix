inputs:

let
  cfg = import ./configuration.nix;
  inherit (cfg) system;

  # -- flake modules
  flakemods = with inputs; [
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    home-manager.nixosModules.home-manager
    nix-flatpak.nixosModules.nix-flatpak
    nix-index-database.nixosModules.default
  ];

  # -- home-manager modules
  hmModules = [
    inputs.nixcord.homeModules.nixcord
    inputs.pear-desktop.homeManagerModules.default
  ];
in
{
  nixosConfigurations.${system.hostname} = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = cfg;

    modules = [
      ./modules
      {
        nixpkgs.hostPlatform = system.arch;
        nixpkgs.overlays = [
          inputs.nix-gaming-edge.overlays.proton-cachyos
        ];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-bak";
          extraSpecialArgs = cfg;
          sharedModules = hmModules;
        };
      }
    ] ++ flakemods;
  };
}
