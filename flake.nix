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
                ];
              }
              ./common/configuration.nix
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
                    aerospace = prev.aerospace.overrideAttrs (_old: {
                      version = "0.20.0";
                      src = prev.fetchzip {
                        url = "https://github.com/tymscar/AeroSpace/releases/download/v0.20.0/AeroSpace-v0.20.0.zip";
                        sha256 = "00bb3bvm6yjabdd9zw51m3qcjm795wkv9iwjajdbb9q151a72aa7";
                      };
                      postInstall = ":";
                    });
                  })
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
