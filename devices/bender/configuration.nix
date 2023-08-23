{ config, pkgs, ... }:

let
  commonConfig = import ../../common/configuration.nix {
    inherit config pkgs;
    overrides = {
      networking.hostName = "bender";

      swapDevices = pkgs.lib.mkForce [ ];

      hardware = {
        pulseaudio.enable = false;
        opengl.enable = true;
        nvidia = {
          package = config.boot.kernelPackages.nvidiaPackages.stable;
          modesetting.enable = true;
        };
      };

      systemd.targets = {
        sleep.enable = false;
        suspend.enable = false;
        hibernate.enable = false;
        hybrid-sleep.enable = false;
      };

      programs.dconf.enable = true;

      services = {
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
        };
        getty.autologinUser = "tymscar";
        xserver = {
          layout = "us";
          xkbVariant = "";
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
          };
          windowManager.i3 = { enable = true; };
          displayManager.sessionCommands = ''
            xrandr --output DP-3 --mode 480x1920 --pos 622x1518 --rotate left
            xrandr --output DP-0 --primary --mode 3440x1440 --rate 144 --pos 0x78 --rotate normal
            xrandr --output HDMI-0 --mode 3840x2160 --pos 3440x0 --rotate normal
          '';
        };
      };
    };
  };
in { imports = [ ./hardware-configuration.nix ]; } // commonConfig
