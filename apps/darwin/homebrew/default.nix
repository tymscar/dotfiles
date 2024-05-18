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
      "arc"
      "blender"
      "chatgpt"
      "coconutbattery"
      "cyberduck"
      "discord"
      "switchresx"
      "vlc"
    ];
    masApps = {
      Xcode = 497799835;
    };
  };
}
