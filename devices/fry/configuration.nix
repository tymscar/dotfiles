{
  lib,
  ...
}:
{
  imports = [
    ../../common/darwin.nix
  ];

  homebrew = {
    brews = [ ];
    casks = [
      "android-studio"
      "orbstack"
      "camo-studio"
      "karabiner-elements"
      "firefox@developer-edition"
      "zen"
    ];
    masApps = {
      "Slack" = 803453959;
    };
  };

  system.defaults = {
    dock = {
      persistent-apps = [
        "/System/Applications/System Settings.app"
        "/System/Applications/Utilities/Activity Monitor.app"
      ];
    };
  };

  ids.gids.nixbld = 350;
}
