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
