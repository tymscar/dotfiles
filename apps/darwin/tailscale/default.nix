{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.tailscale-gui ];
}
