{ config, lib, ... }:
{
  services.tesla-fan-control = {
    enable = true;
    extraKernelModules = [ "nct6775" ];
    settings = builtins.readFile ./settings.conf;
  };
  systemd.services.nvidia-power-limit = lib.mkForce { };
}
