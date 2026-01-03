{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlays.url = "github:nix-community/emacs-overlay";
  };

  outputs =
    {
      self,
      mac-app-util,
      nix-vscode-extensions,
      nix-darwin,
      nixpkgs,
      nur,
      nixneovimplugins,
      alacritty-theme,
      homeManager,
      agenix,
      emacs-overlays,
      ...
    }:
    let
      nixosDeviceConfig =
        device:
        let
          system = "x86_64-linux";
          linuxUsername = "tymscar";
        in
        {
          "${device}" = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit device;
              accountUsername = linuxUsername;
            };
            modules = [
              agenix.nixosModules.default
              {
                nixpkgs.overlays = [
                  nixneovimplugins.overlays.default
                  alacritty-theme.overlays.default
                  nur.overlays.default
                  emacs-overlays.overlays.default
                ];
              }
              ./devices/${device}/configuration.nix
              homeManager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.tymscar = import ./devices/${device}/home.nix;
                home-manager.extraSpecialArgs = {
                  inherit device;
                  accountUsername = linuxUsername;
                  os = "linux";
                  nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
                };
              }
            ];
          };
        };

      macosDeviceConfig =
        device:
        let
          system = "aarch64-darwin";
          macUsername = if device == "fry" then "oscar.molnar" else "tymscar";
        in
        {
          "${device}" = nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = {
              inherit device;
              accountUsername = macUsername;
            };
            modules = [
              {
                nixpkgs.overlays = [
                  nixneovimplugins.overlays.default
                  alacritty-theme.overlays.default
                  nur.overlays.default
                  (final: prev: {
                    aerospace = prev.aerospace.overrideAttrs (_old: rec {
                      version = "0.21.0";
                      src = prev.fetchzip {
                        url = "https://github.com/tymscar/AeroSpace/releases/download/v${version}/AeroSpace-v${version}.zip";
                        sha256 = "sha256-fOSrG3sDDjuchZeaNRS1yySPtB5RUMLd0JyayfNrTOU=";
                      };
                      postInstall = ":";
                    });
                    raycast = prev.raycast.overrideAttrs (old: rec {
                      version = "1.104.0";
                      src = prev.fetchurl {
                        name = "Raycast.dmg";
                        url = "https://releases.raycast.com/releases/${version}/download?build=arm";
                        hash = "sha256-feEHK3LOycG2vKqQZfMrSkw+NY2yCFYK4RM4iodaV6Y=";
                      };
                    });
                  })
                  emacs-overlays.overlays.default
                ];
              }
              ./devices/${device}/configuration.nix
              homeManager.darwinModules.home-manager
              {
                home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${macUsername} = import ./devices/${device}/home.nix;
                home-manager.extraSpecialArgs = {
                  inherit device;
                  accountUsername = macUsername;
                  os = "darwin";
                  nix-vscode-extensions = nix-vscode-extensions.extensions.${system};
                };
              }
            ];
          };
        };

      nixosDeviceNames = [
        "bender"
        "farnsworth"
      ];
      macosDeviceNames = [
        "zoidberg"
        "fry"
      ];
    in
    {
      nixosConfigurations = builtins.foldl' (
        acc: device: acc // nixosDeviceConfig device
      ) { } nixosDeviceNames;
      darwinConfigurations = builtins.foldl' (
        acc: device: acc // macosDeviceConfig device
      ) { } macosDeviceNames;

      darwinPackages = self.darwinConfigurations."zoidberg".pkgs;
    };
}
