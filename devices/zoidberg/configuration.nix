{
  lib,
  ...
}:
{
  imports = [
    ../../common/darwin.nix
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
    ];
  };

  system.defaults = {
    loginwindow.LoginwindowText = "If found, contact oscar@tymscar.com for reward";
    dock = {
      persistent-apps = [
        "/Applications/Arc.app"
        "/Applications/Discord.app"
        "/System/Applications/iPhone Mirroring.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/Utilities/Activity Monitor.app"
      ];
    };
  };

  ids.gids.nixbld = 30000;
}
