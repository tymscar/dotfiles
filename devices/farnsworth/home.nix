{ config
, lib
, pkgs
, ...
}:

let
  i3wm-module = import ../../apps/home-manager/i3wm {
    inherit pkgs;
    inherit lib;
    inherit config;
  };
in
{
  imports = [
    ../../common/home.nix
    i3wm-module
    ../../apps/home-manager/alacritty
    ../../apps/home-manager/zsh
    ../../apps/home-manager/pcmanfm
    ../../apps/home-manager/rofi
    ../../apps/home-manager/polybar
    ../../apps/home-manager/git
    ../../apps/home-manager/neovim
    ../../apps/home-manager/gpg
    ../../apps/home-manager/vscode
  ];

  home.packages = with pkgs; [
    bat
    cargo
    feh
    gedit
    gnupg
    gotop
    htop
    lsd
    lxappearance
    neofetch
    p7zip
    pcmanfm
    polybar
    rofi
    rust-analyzer
    traceroute
    usbimager
    usbutils
    qemu
    libvirt
    OVMFFull
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
