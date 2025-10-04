{ pkgs, ... }:

let
  aerospacercContent = pkgs.lib.importTOML ./aerospacerc;
in
{
  services.aerospace = {
    enable = true;
    settings = aerospacercContent;
  };
}
