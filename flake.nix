{
  description = "Tymscar's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    catppuccin-vsc.url = "https://flakehub.com/f/catppuccin/vscode/*.tar.gz";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixneovimplugins, alacritty-theme, catppuccin-vsc, homeManager, ...}:
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
                alacritty-theme.overlays.default
                catppuccin-vsc.overlays.default
              ];
            }
            ./common/configuration.nix
            (import ./devices/${device}/configuration.nix { hostname = device; pkgs = pkgs;})
            homeManager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.tymscar = import ./devices/${device}/home.nix;
              home-manager.extraSpecialArgs = {
                inherit device;
              };
            }
          ];
        };
      };

      deviceNames = [ "bender" ];
    in
    {
      nixosConfigurations =
        builtins.foldl' (acc: device: acc // deviceConfig device) { }
          deviceNames;
    };
}
