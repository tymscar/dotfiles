{ pkgs, rustrover, hostname, ... }:

let
  commonConfig = import ../../common/configuration.nix {
    inherit pkgs rustrover;
    overrides = {
      networking = {
        hostName = hostname;
        firewall = {
          enable = true;
          allowedTCPPorts = [ 22 80 443 3030 5173 ];
          allowedUDPPorts = [ 53 ];
        };
      };
    };
  };
in
{ imports = [ ./hardware-configuration.nix ]; } // commonConfig
