{
  pkgs,
  device,
  accountUsername,
  lib,
  ...
}:
let
  defaultHomebrew = import ../../apps/darwin/homebrew/default.nix { };
in
{

  imports = [
    ../../apps/darwin/aerospace
  ];

  homebrew = lib.mkMerge [
    defaultHomebrew.homebrew
    {
      brews = [ "asdf" ];
      casks = [
        "android-studio"
        "docker"
        "ghostty"
        "elgato-camera-hub"
        "firefox@developer-edition"
      ];
    }
  ];

  environment.extraInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.monaspace
      nerd-fonts.noto
    ];
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    defaults = {
      ActivityMonitor.IconType = 6;
      screencapture = {
        disable-shadow = true;
        type = "png";
      };
      menuExtraClock = {
        Show24Hour = true;
        ShowDayOfWeek = true;
        ShowDayOfMonth = true;
        ShowSeconds = true;
        ShowDate = 1;
      };
      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXShowPosixPathInTitle = true;
      };
      dock = {
        magnification = true;
        mru-spaces = false;
        minimize-to-application = true;
        tilesize = 16;
        largesize = 64;
        show-recents = false;
        autohide = true;
        wvous-bl-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-br-corner = 1;
        persistent-apps = [
          "/System/Applications/System Settings.app"
          "/System/Applications/Utilities/Activity Monitor.app"
        ];
        persistent-others = [ "/Users/${accountUsername}/Downloads" ];
      };
      NSGlobalDomain = {
        AppleMeasurementUnits = "Centimeters";
        AppleMetricUnits = 1;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        AppleShowScrollBars = "WhenScrolling";
        AppleTemperatureUnit = "Celsius";
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 0;
        KeyRepeat = 0;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        _HIHideMenuBar = false;
        "com.apple.mouse.tapBehavior" = 1;
        AppleInterfaceStyle = "Dark";
      };
      universalaccess = {
        closeViewScrollWheelToggle = true;
        reduceMotion = true;
      };
      ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
    };
  };

  nixpkgs.config.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;
  programs.zsh.enable = true;
  users.users."${accountUsername}" = {
    description = "Oscar Molnar";
    shell = pkgs.zsh;
    home = "/Users/${accountUsername}";
  };
  networking.hostName = device;
  services.nix-daemon.enable = true;
  nix = {
    settings.experimental-features = "nix-command flakes";
    nixPath = [
      "nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz"
    ];
  };
  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
