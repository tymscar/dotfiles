{ pkgs, device, ... }:

let
  apple-color-emoji = pkgs.stdenv.mkDerivation {
    name = "apple-color-emoji";
    version = "16.4-patch.1";
    src = pkgs.fetchurl {
      url =
        "https://github.com/samuelngs/apple-emoji-linux/releases/download/v16.4-patch.1/AppleColorEmoji.ttf";
      sha256 = "15assqyxax63hah0g51jd4d4za0kjyap9m2cgd1dim05pk7mgvfm";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/share/fonts/truetype/apple-color-emoji
      cp $src $out/share/fonts/truetype/apple-color-emoji/AppleColorEmoji.ttf
    '';
  };
in {
  imports = [ ./hardware-configuration.nix ../../apps/sunshine ];

  networking = {
    hostName = device;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 3030 5173 ];
      allowedUDPPorts = [ 53 ];
    };
  };

  swapDevices = pkgs.lib.mkForce [ ];

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
    nvidia = { modesetting.enable = true; };
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Monaspace" "Noto" ]; })
      apple-color-emoji
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Monaspace" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    getty.autologinUser = "tymscar";
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [ "nvidia" ];
      enable = true;
      desktopManager = { xterm.enable = false; };

      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "tymscar";
        lightdm = {
          enable = true;
          greeter.enable = false;
        };
        sessionCommands = ''
          xrandr --output DP-3 --mode 480x1920 --pos 622x1518 --rotate left
          xrandr --output DP-0 --primary --mode 3440x1440 --rate 144 --pos 0x78 --rotate normal
          xrandr --output HDMI-0 --mode 3840x2160 --pos 3440x0 --rotate normal
        '';
      };
      windowManager.i3 = { enable = true; };
    };
  };
}
