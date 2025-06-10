{ lib, ... }:

{
  programs.ssh = {
    enable = true;
    forwardAgent = lib.mkForce true;
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
