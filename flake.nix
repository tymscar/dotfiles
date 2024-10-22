{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { self, mac-app-util, nix-vscode-extensions, nix-darwin, nixpkgs
    , nixneovimplugins, alacritty-theme, homeManager, ... }:
    let
      nixosDeviceConfig = device:
        let system = "x86_64-linux";
        in {
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
                home-manager.users.tymscar =
                  import ./devices/${device}/home.nix;
                home-manager.extraSpecialArgs = {
                  inherit device;
                  os = "linux";
                  nix-vscode-extensions =
                    nix-vscode-extensions.extensions.${system};
                };
              }
            ];
          };
        };

      macosDeviceConfig = device:
        let system = "aarch64-darwin";
        in {
          "${device}" = nix-darwin.lib.darwinSystem {
            inherit system;
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
                home-manager.sharedModules =
                  [ mac-app-util.homeManagerModules.default ];
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.tymscar =
                  import ./devices/${device}/home.nix;
                home-manager.extraSpecialArgs = {
                  inherit device;
                  os = "darwin";
                  nix-vscode-extensions =
                    nix-vscode-extensions.extensions.${system};
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
