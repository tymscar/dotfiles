{ pkgs, ... }:

{
  imports = [
    ../apps/home-manager/git
    ../apps/home-manager/lazygit
    ../apps/home-manager/neovim
    ../apps/home-manager/gpg
    ../apps/home-manager/zsh
    ../apps/home-manager/atuin
  ];

  home.packages = with pkgs; [
    man-pages
    man-pages-posix
    bat
    tree
    ripgrep
    gnupg
    gotop
    htop
    lsd
    fastfetch
    nixfmt
    p7zip
    cmatrix
    cargo
    rust-analyzer
  ];

  home.stateVersion = "22.11";
}
