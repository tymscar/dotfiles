{ pkgs, ... }:
{
  imports = [
    ../../common/home.nix
    ../../apps/darwin/wallpaper
    ../../apps/darwin/karabiner
    ../../apps/home-manager/brightintosh
    ../../apps/home-manager/ghostty
    ../../apps/home-manager/idea
    ../../apps/home-manager/ssh
    ../../apps/home-manager/tmux
    ../../apps/home-manager/opencode
    ../../apps/darwin/airpods-nc-toggle
  ];

  home.packages = with pkgs; [
    _1password-cli
    uv
    appcleaner
    bottom
    pinentry_mac
    raycast
    rustc
    yt-dlp
    ffmpeg
  ];
}
