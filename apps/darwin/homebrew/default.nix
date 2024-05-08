{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ "LizardByte/homebrew" "homebrew/services" ];
    brews = [
      "swiftlint"
      {
        name = "LizardByte/homebrew/sunshine";
        args = [ ];
        start_service = true;
        restart_service = "changed";
      }
    ];
    casks = [
      "1password"
      "coconutbattery"
      "blender"
      "arc"
      "discord"
      "vlc"
    ];
    masApps = {
      Xcode = 497799835;
    };
  };
}
