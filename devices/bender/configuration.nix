{ pkgs, hostname, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  networking = {
    hostName = hostname;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 3030 5173 48010 47989 47990 47984 47999 ];
      allowedUDPPorts = [ 53 47998 47999 48000 ];
    };
  };

  swapDevices = pkgs.lib.mkForce [ ];

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
    };
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  systemd.services.sunshine =
    {
      description = "Sunshine Service";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.sudo}/bin/sudo ${pkgs.sunshine}/bin/sunshine";
        Restart = "always";
      };
    };



  programs.zsh.enable = true;
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
      xkb =
        {
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
