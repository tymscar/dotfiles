{ config, ... }:

let
  threadStick = "/dev/serial/by-id/usb-Itead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_V2_cccfc40e26f1ef11b79dbd0a6d9880ab-if00-port0";
  lanInterface = "enp2s0";
in
{
  services.openthread-border-router = {
    enable = true;
    backboneInterfaces = [ lanInterface ];
    radio = {
      device = threadStick;
      baudRate = 460800;
    };
  };

  services.matter-server = {
    enable = true;
    extraArgs = {
      listen-address = "127.0.0.1";
      primary-interface = lanInterface;
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ 5353 ];
    trustedInterfaces = [ config.services.openthread-border-router.interfaceName ];
  };
}

