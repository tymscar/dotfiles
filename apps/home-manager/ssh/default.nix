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
      "git.tymscar.com" = {
        hostname = "git.tymscar.com";
        port = 2222;
      };
    };
  };
}
