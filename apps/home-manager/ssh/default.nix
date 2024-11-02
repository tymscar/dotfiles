{ ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
