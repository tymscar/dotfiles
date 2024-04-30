{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ ];
    brews = [ "swiftlint" ];
    casks = [
      "1password"
      "coconutbattery"
      "blender"
      "brave-browser"
      "discord"
      "vlc"
    ];
    masApps = {
      Xcode = 497799835;
      Amphetamine = 937984704;
    };
  };
}
