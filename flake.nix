{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixneovimplugins, homeManager, nix-doom-emacs, ...}:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      deviceConfig = device: {
        "${device}" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                nixneovimplugins.overlays.default
              ];
            }
            (import ./devices/${device}/configuration.nix { hostname = device; pkgs = pkgs; })
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
