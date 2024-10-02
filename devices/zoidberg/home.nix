{ pkgs, ... }: {
  imports = [
    ../../common/home.nix
    ../../apps/darwin/wallpaper
    ../../apps/home-manager/zsh
    ../../apps/home-manager/git
    ../../apps/home-manager/neovim
    ../../apps/home-manager/alacritty
    ../../apps/home-manager/emacs
    ../../apps/home-manager/gpg
    ../../apps/home-manager/vscode
  ];

  home.packages = with pkgs; [
    appcleaner
    cargo
    gotop
    raycast
    gitkraken
    rust-analyzer
  ];
}
