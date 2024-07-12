{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ "LizardByte/homebrew" "homebrew/services" ];
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
      "1password"
      "audacity"
      "arc"
      "blender"
      "chatgpt"
      "coconutbattery"
      "cyberduck"
      "discord"
      "home-assistant"
      "switchresx"
      "vlc"
      "zed"
    ];
    masApps = {
      Xcode = 497799835;
    };
  };
}
