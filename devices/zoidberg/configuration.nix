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
      taps = [
        "LizardByte/homebrew"
        "homebrew/services"
      ];
      brews = [
        "screenresolution"
        "swiftlint"
        {
          name = "LizardByte/homebrew/sunshine";
          args = [ ];
          start_service = true;
          restart_service = "changed";
        }
      ];
      casks = [
        "arduino-ide"
        "audacity"
        "blender"
        "discord"
        "home-assistant"
        "karabiner-elements"
        "switchresx"
        "macs-fan-control"
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
      emacs-all-the-icons-fonts
    ];
  };

  system = {
    primaryUser = accountUsername;
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
      loginwindow.LoginwindowText = "If found, contact oscar@tymscar.com for reward";
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
          "/Applications/Arc.app"
          "/Applications/Discord.app"
          "/System/Applications/iPhone Mirroring.app"
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

  security.pam.services.sudo_local.touchIdAuth = true;
  programs.zsh.enable = true;
  users.users.tymscar = {
    description = "Oscar Molnar";
    shell = pkgs.zsh;
    home = "/Users/${accountUsername}";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI2Dde4RdoVd6xILo3lcL/PIUxY5OBMCPS6ABPLsSO60M8fDA/bScYVcRJBTKQzRYpVKv5lOLIqx+GS0Q3rX2YikLyUq2TARyU2fm3QTUeRqNNONBZo791ZWV7riU6YGj4Am7VRou513VwWPtyE5tLywtAIkaxG/gYvqz5oJK4n4izBGGO55hYUNa/fR7KCeX6s2dAh0ds9qwe94+vYEAhYz42M3f4f0QxH4vlVajUXY7JkdgwqVxKmztRONZPxKi7mEFjx0Ypx45f3p7qQm4kdnMnVbOqjxWTqPPli9qBHC1Uv0FINvxpLASSWR6al0JgYKnAQ5kkcdegPgPyEOgr tymscar@Bender"
    ];
  };
  networking.hostName = device;
  nix = {
    settings.experimental-features = "nix-command flakes";
    nixPath = [
      "nixpkgs=https://github.com/NixOS/nixpkgs-channels/archive/nixpkgs-unstable.tar.gz"
    ];
  };

  ids.gids.nixbld = 30000;

  system.stateVersion = 4;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
