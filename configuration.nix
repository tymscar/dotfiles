{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  swapDevices = pkgs.lib.mkForce [ ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  hardware = {
    pulseaudio.enable = false;
    opengl.enable = true;
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
    };
  };

  networking = {
    hostName = "bender";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  users.users.tymscar = {
    isNormalUser = true;
    description = "Oscar Molnar";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
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
      layout = "us";
      xkbVariant = "";
      videoDrivers = [ "nvidia" ];
      enable = true;
      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        autoLogin.enable = true;
        autoLogin.user = "tymscar";
        lightdm = {
          enable = true;
          greeter.enable = false;
        };
      };
      windowManager.i3 = {
        enable = true;
      };
      displayManager.sessionCommands = ''
        xrandr --output DP-3 --mode 480x1920 --pos 622x1518 --rotate left
        xrandr --output DP-0 --primary --mode 3440x1440 --rate 144 --pos 0x78 --rotate normal
        xrandr --output HDMI-0 --mode 3840x2160 --pos 3440x0 --rotate normal
      '';
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    git
    killall
    lsof
    nixpkgs-fmt
    pciutils
    pinentry-gtk2
    vim
    wget
  ];

  system.stateVersion = "22.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
