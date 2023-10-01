{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
    rustrovernixpkgs.url = "github:NixOS/nixpkgs/72a455b13db608ba0a9dcf8b93fdbb35ea4a9311";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rustrovernixpkgs, nixneovimplugins, homeManager }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      #rustroverPkgs = rustrovernixpkgs.legacyPackages.${system};
      rustroverPkgs = import rustrovernixpkgs {
        config = {
          allowUnfree = true;
        };
        system = system;
      };

      deviceConfig = device: {
        "${device}" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                nixneovimplugins.overlays.default
              ];
            }
            (import ./devices/${device}/configuration.nix { hostname = device; pkgs = pkgs; rustrover = rustroverPkgs.jetbrains.rust-rover; })
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
    in
    {
      nixosConfigurations =
        builtins.foldl' (acc: device: acc // deviceConfig device) { }
          deviceNames;
    };
}
