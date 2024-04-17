{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
    cmatrix
  ];

  home.stateVersion = "22.11";
}
