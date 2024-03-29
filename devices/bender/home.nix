{ pkgs, ... }:

let
  blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
  # https://github.com/NixOS/nixpkgs/issues/272221#issuecomment-1840482987
  sunshineWithCuda = pkgs.sunshine.overrideAttrs (prev: {
    runtimeDependencies = prev.runtimeDependencies
      ++ [ pkgs.linuxKernel.packages.linux_zen.nvidia_x11 ];
  });
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
    sunshineWithCuda
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
