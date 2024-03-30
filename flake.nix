{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/pull/294641/head";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nixneovimplugins, alacritty-theme, homeManager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      deviceConfig = device: {
        "${device}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit device; };
          modules = [
            {
              nixpkgs.overlays = [
                nixneovimplugins.overlays.default
                alacritty-theme.overlays.default
              ];
            }
            ./common/configuration.nix
            ./devices/${device}/configuration.nix
            homeManager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tymscar = import ./devices/${device}/home.nix;
              home-manager.extraSpecialArgs = { inherit device; };
            }
          ];
        };
      };

      deviceNames = [ "bender" ];
    in {
      nixosConfigurations =
        builtins.foldl' (acc: device: acc // deviceConfig device) { }
        deviceNames;
    };
}
