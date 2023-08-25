{ pkgs, hostname, ... }:

let
  commonConfig = import ../../common/configuration.nix {
    inherit pkgs;
    overrides = {
      networking.hostName = hostname;
    };
  };
in { imports = [ ./hardware-configuration.nix ]; } // commonConfig
