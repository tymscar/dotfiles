{ pkgs, ... }:

let blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
in {
  imports = [
    ../../common/home.nix
    ../../apps/home-manager/vscode
    ../../apps/home-manager/alacritty
    ../../apps/home-manager/zsh
    ../../apps/home-manager/pcmanfm
    ../../apps/home-manager/i3wm
    ../../apps/home-manager/rofi
    ../../apps/home-manager/polybar
    ../../apps/home-manager/git
    ../../apps/home-manager/neovim
    ../../apps/home-manager/emacs
    ../../apps/home-manager/gpg
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
