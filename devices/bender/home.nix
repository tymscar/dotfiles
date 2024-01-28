{ pkgs, config, nix-doom-emacs, ... }:

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
      (jetbrains.plugins.addPlugins jetbrains.webstorm [ "github-copilot" ])
      yubikey-manager
    ];

    overrides = {
      services.gpg-agent.pinentryFlavor = "gtk2";

      gtk = {
        enable = true;
        theme = {
          package = pkgs.catppuccin-gtk;
          name = "Catppuccin-Frappe-Standard-Blue-Dark";
        };
        iconTheme = {
          package = pkgs.vimix-icon-theme;
          name = "Vimix";
        };
      };
    };
  };
in
{
  imports = [
    nix-doom-emacs.hmModules
    ./apps/zsh
    ./apps/pcmanfm
    ./apps/i3wm
    ./apps/rofi
    ./apps/polybar
    ./apps/git
  ];

  home.packages = commonHomeConfig.home.packages;
  home.stateVersion = commonHomeConfig.home.stateVersion;
}
