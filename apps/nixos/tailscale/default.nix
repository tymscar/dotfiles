{ config, ... }:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "server";
    extraSetFlags = [
      "--advertise-exit-node"
      "--advertise-routes=10.0.0.0/16"
    ];
  };

  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
}
