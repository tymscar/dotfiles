{ pkgs, config, ... }:

let
  JBPluginsPkgs = import
    (builtins.fetchTarball {
      url = https://github.com/NixOS/nixpkgs/archive/pull/223593/head.tar.gz;
      sha256 = "sha256:1wc70sq3nzk58kp9bbzlw2f57df02d7jclf5dhqc2sr0jk3psiaf";
    })
    {
      config = { allowUnfree = true; };
      localSystem = { system = "x86_64-linux"; };
    };
  blenderWithCuda = pkgs.blender.override { cudaSupport = true; };
  webstormWithPlugins = with JBPluginsPkgs; (jetbrains.plugins.addPlugins jetbrains.webstorm [ "github-copilot" ]);
in
{
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
    shutter
    usbimager
    vscode
    webstormWithPlugins
    yubikey-manager
  ];

  imports = [
    ./apps/zsh
    ./apps/pcmanfm
    ./apps/i3wm
    ./apps/rofi
    ./apps/polybar
    ./apps/git
  ];

  services.gpg-agent.pinentryFlavor = "gtk2";


  home.stateVersion = "22.11";
}
