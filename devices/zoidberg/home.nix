{ pkgs, ... }:
{
  imports = [
    ../../common/home.nix
    ../../apps/darwin/wallpaper
    ../../apps/darwin/karabiner
    ../../apps/home-manager/ghostty
    ../../apps/home-manager/idea
    ../../apps/home-manager/ssh
#    ../../apps/home-manager/emacs
  ];

  home.packages = with pkgs; [
    _1password-cli
    uv
    appcleaner
    bottom
    pinentry_mac
    raycast
    rustc
#    yt-dlp
    ffmpeg
  ];
}
