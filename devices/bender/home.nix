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
    ../../apps/home-manager/pcmanfm
    ../../apps/home-manager/rofi
    ../../apps/home-manager/polybar
    ../../apps/home-manager/emacs
  ];

  home.packages = with pkgs; [
    _1password-gui
    blenderWithCuda
    brave
    discord
    feh
    fsv
    gedit
    lxappearance
    pavucontrol
    pcmanfm
    polybar
    rofi
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
