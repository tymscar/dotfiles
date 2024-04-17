{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    sunshine-service-pr.url = "github:NixOS/nixpkgs/pull/294641/head";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, sunshine-service-pr, nixneovimplugins
    , alacritty-theme, homeManager, ... }:
    let
      nixosDeviceConfig = device: {
        "${device}" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit device; };
          modules = [
            {
              nixpkgs.overlays = [
                nixneovimplugins.overlays.default
                alacritty-theme.overlays.default
              ];
            }
            "${sunshine-service-pr}/nixos/modules/services/networking/sunshine.nix"
            ./common/configuration.nix
            ./devices/${device}/configuration.nix
            homeManager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tymscar = import ./devices/${device}/home.nix;
              home-manager.extraSpecialArgs = {
                inherit device;
                os = "linux";
              };
            }
          ];
        };
      };

      macosDeviceConfig = device: {
        "${device}" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit device; };
          modules = [
            {
              nixpkgs.overlays = [
                nixneovimplugins.overlays.default
                alacritty-theme.overlays.default
              ];
            }
            ./devices/${device}/configuration.nix
            homeManager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tymscar = import ./devices/${device}/home.nix;
              home-manager.extraSpecialArgs = {
                inherit device;
                os = "darwin";
              };
            }
          ];
        };
      };

      nixosDeviceNames = [ "bender" ];
      macosDeviceNames = [ "zoidberg" ];
    in {
      nixosConfigurations =
        builtins.foldl' (acc: device: acc // nixosDeviceConfig device) { }
        nixosDeviceNames;
      darwinConfigurations =
        builtins.foldl' (acc: device: acc // macosDeviceConfig device) { }
        macosDeviceNames;

      darwinPackages = self.darwinConfigurations."zoidberg".pkgs;
    };
}
