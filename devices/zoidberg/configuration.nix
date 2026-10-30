{
  lib,
  accountUsername,
  ...
}:
{
  imports = [
    ../../common/darwin.nix
    ../../apps/darwin/tailscale
  ];

  homebrew = {
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
      "bambu-studio"
      "autodesk-fusion"
      "nordvpn"
    ];
    masApps = {
      "Amphetamine" = 937984704;
    };
  };

  system.defaults = {
    loginwindow.LoginwindowText = "If found, contact oscar@tymscar.com for reward";
    dock = {
      persistent-apps = [
        "/Users/${accountUsername}/Applications/Zen.app"
        "/Applications/Discord.app"
        "/System/Applications/iPhone Mirroring.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/Utilities/Activity Monitor.app"
      ];
    };
  };

  launchd.user.envVariables.MOZ_LEGACY_PROFILES = "1";

  ids.gids.nixbld = 30000;
}
