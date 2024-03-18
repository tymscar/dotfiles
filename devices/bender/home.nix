{ pkgs, config, ... }:

let
  blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
in
{
  imports = [
    ../../common/home.nix
    ../../apps/zsh
    ../../apps/pcmanfm
    ../../apps/i3wm
    ../../apps/rofi
    ../../apps/polybar
    ../../apps/git
    ../../apps/neovim
  ];

  home.packages = with pkgs; [
    _1password-gui
    alacritty
    bat
    blenderWithCuda
    brave
    discord
    feh
    fsv
    gnupg
    gotop
    htop
    lsd
    neofetch
    p7zip
    pavucontrol
    pcmanfm
    polybar
    rofi
    usbutils
    shutter
    usbimager
    vscode
    lxappearance
    yubikey-manager
    gedit
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Frappe-Standard-Blue-Dark ";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Vimix";
      package = pkgs.vimix-icon-theme;
    };
  };
}
