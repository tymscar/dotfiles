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
  ];

  home.packages = with pkgs; [ cargo gotop raycast rust-analyzer ];
}
