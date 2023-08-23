{ pkgs, config, ... }:

let
  commonHomeConfig = import ../../common/home.nix {
    inherit pkgs config;
    extraPackages = with pkgs; [ ];
  };
in {
  imports = [
    ../../apps/zsh
    ../../apps/git
  ];

  home.packages = commonHomeConfig.home.packages;
  home.stateVersion = commonHomeConfig.home.stateVersion;
}
