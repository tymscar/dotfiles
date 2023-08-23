
{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, homeManager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      deviceConfig = device: {
        "${device}" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./devices/${device}/configuration.nix
            homeManager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tymscar = import ./devices/${device}/home.nix;
            }
          ];
        };
      };

      deviceNames = [ "bender" "vm" ];
    in {
      nixosConfigurations =
        builtins.foldl' (acc: device: acc // deviceConfig device) { }
        deviceNames;
    };
}
