{ pkgs, config, ... }:

let
  blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
  # https://github.com/NixOS/nixpkgs/issues/272221#issuecomment-1840482987
  sunshineWithCuda = pkgs.sunshine.overrideAttrs (prev: {
    runtimeDependencies = prev.runtimeDependencies ++ [
      pkgs.linuxKernel.packages.linux_zen.nvidia_x11
    ];
  });
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
    sunshineWithCuda
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Red-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "red" ];
        variant = "mocha";
        size = "compact";
      };
    };
    iconTheme = {
      name = "Vimix-dark";
      package = pkgs.vimix-icon-theme;
    };
  };
}
