{ pkgs, ... }:
{
  imports = [
    ../../common/home.nix
    ../../apps/darwin/wallpaper
    ../../apps/darwin/karabiner
    ../../apps/home-manager/zsh
    ../../apps/home-manager/git
    ../../apps/home-manager/neovim
    ../../apps/home-manager/ghostty
        #    ../../apps/home-manager/emacs
    ../../apps/home-manager/gpg
    ../../apps/home-manager/vscode
    ../../apps/home-manager/zed
    ../../apps/home-manager/idea
    ../../apps/home-manager/ssh
    ../../apps/home-manager/atuin
  ];

  home.packages = with pkgs; [
    _1password-cli
    uv
    appcleaner
    bottom
    cargo
    fossil
    gitkraken
    gotop
    pinentry_mac
    raycast
    rust-analyzer
    rustc
    yt-dlp
    ffmpeg
  ];
}
