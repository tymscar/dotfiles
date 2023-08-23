{ config, pkgs, ... }:

let
  commonConfig = import ../../common/configuration.nix {
    inherit config pkgs;
    overrides = { networking.hostName = "vm"; };
  };
in { imports = [ ./hardware-configuration.nix ]; } // commonConfig
