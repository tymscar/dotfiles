{ pkgs, ... }:

let
  brightintosh = import ../../../packages/brightintosh { inherit pkgs; };
in
{
  home.packages = [ brightintosh ];
}
