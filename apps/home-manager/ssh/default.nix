{ lib, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        forwardAgent = lib.mkForce true;
        extraOptions = {
          "IgnoreUnknown" = "UseKeychain";
          "UseKeychain" = "yes";
        };
      };
    };
  };
}
