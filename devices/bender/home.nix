{
  config,
  lib,
  pkgs,
  ...
}:

let
  blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
  aioImage = builtins.fetchurl {
    url = "https://media.tenor.com/GIYnmPBTFsUAAAAM/keyboard-anime.gif";
    sha256 = "sha256:1l16fz0zk5g79dbd0r9mj5qflj4fv60hl640ybc9icbvx9926j4w";
  };
  i3wm-module = import ../../apps/home-manager/i3wm {
    inherit pkgs;
    inherit lib;
    inherit config;
    additionalStartupCommands = [
      {
        command = "sudo ${pkgs.liquidctl}/bin/liquidctl -m nzxt set lcd screen gif ${aioImage}";
        always = true;
        notification = false;
      }
    ];
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
    traceroute
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
