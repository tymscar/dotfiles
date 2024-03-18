{ pkgs, config, extraPackages ? [ ], overrides ? { }, ... }:

{
  home.packages = with pkgs;
    [
      bat
      tree
      ripgrep
      gnupg
      gotop
      htop
      lazygit
      lsd
      neofetch
      p7zip
      jetbrains-mono
      cmatrix
      traceroute
    ] ++ extraPackages;

  home.stateVersion = "22.11";
} // overrides
