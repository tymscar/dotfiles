{ pkgs, config, ... }:

let
  commonHomeConfig = import ../../common/home.nix {
    inherit pkgs config;
    extraPackages = with pkgs; [
      nodejs_20
      cargo
      rustc
      jetbrains.ruby-mine
      crystal
      shards
      gnumake
    ];
  };
in
{
  imports = [
    ../../apps/zsh
    ../../apps/git
    ../../apps/neovim
  ];

  home.packages = commonHomeConfig.home.packages;
  home.stateVersion = commonHomeConfig.home.stateVersion;
}
