{ pkgs, config, ... }:

let
  blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
  commonHomeConfig = import ../../common/home.nix {
    inherit pkgs config;
    extraPackages = with pkgs; [
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
      shutter
      usbimager
      vscode
      lxappearance
      yubikey-manager
      gedit
    ];

    overrides = {
      services.gpg-agent.pinentryFlavor = "gtk2";

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
    };
  };
in
{
  imports = [
    ../../apps/zsh
    ../../apps/pcmanfm
    ../../apps/i3wm
    ../../apps/rofi
    ../../apps/polybar
    ../../apps/git
    ../../apps/neovim
  ];

  home.packages = commonHomeConfig.home.packages;
  home.stateVersion = commonHomeConfig.home.stateVersion;
}
