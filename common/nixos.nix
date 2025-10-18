{ pkgs, device, ... }:

let
  apple-color-emoji = pkgs.stdenv.mkDerivation {
    name = "apple-color-emoji";
    version = "16.4-patch.1";
    src = pkgs.fetchurl {
      url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v16.4-patch.1/AppleColorEmoji.ttf";
      sha256 = "15assqyxax63hah0g51jd4d4za0kjyap9m2cgd1dim05pk7mgvfm";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/share/fonts/truetype/apple-color-emoji
      cp $src $out/share/fonts/truetype/apple-color-emoji/AppleColorEmoji.ttf
    '';
  };
in
{
  imports = [
    ../apps/nixos/gpg
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
      };
    };
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
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI2Dde4RdoVd6xILo3lcL/PIUxY5OBMCPS6ABPLsSO60M8fDA/bScYVcRJBTKQzRYpVKv5lOLIqx+GS0Q3rX2YikLyUq2TARyU2fm3QTUeRqNNONBZo791ZWV7riU6YGj4Am7VRou513VwWPtyE5tLywtAIkaxG/gYvqz5oJK4n4izBGGO55hYUNa/fR7KCeX6s2dAh0ds9qwe94+vYEAhYz42M3f4f0QxH4vlVajUXY7JkdgwqVxKmztRONZPxKi7mEFjx0Ypx45f3p7qQm4kdnMnVbOqjxWTqPPli9qBHC1Uv0FINvxpLASSWR6al0JgYKnAQ5kkcdegPgPyEOgr tymscar@Bender"
    ];
  };

  networking = {
    hostName = device;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [
        53
      ];
    };
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };

  programs.zsh.enable = true;
  programs.dconf.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.monaspace
      nerd-fonts.noto
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
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
    getty.autologinUser = "tymscar";
    xserver = {
      xkb = {
        layout = "us";
        variant = "";
      };
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
    };
  };

  systemd.tmpfiles.rules = [ "f /home/tymscar/.hushlogin - - - - ''" ];

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    cifs-utils
    git
    killall
    lsof
    nixpkgs-fmt
    pciutils
    pinentry-gtk2
    wget
    gcc_multi
    traceroute
  ];

  system.stateVersion = "22.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
