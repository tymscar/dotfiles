{ pkgs, ... }:

let
  blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
in {
  imports = [
    ../../common/home.nix
    ../../apps/vscode
    ../../apps/alacritty
    ../../apps/zsh
    ../../apps/pcmanfm
    ../../apps/i3wm
    ../../apps/rofi
    ../../apps/polybar
    ../../apps/git
    ../../apps/neovim
    ../../apps/emacs
  ];

  home.packages = with pkgs; [
    _1password-gui
    bat
    blenderWithCuda
    brave
    cargo
    discord
    feh
    fsv
    gedit
    gnupg
    gotop
    htop
    lsd
    lxappearance
    neofetch
    p7zip
    pavucontrol
    pcmanfm
    polybar
    rofi
    rust-analyzer
    shutter
    usbimager
    usbutils
    yubikey-manager
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
  };
}
