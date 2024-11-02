{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
      "homebrew/services"
    ];
    brews = [ ];
    casks = [
      "1password"
      "arc"
      "coconutbattery"
      "cyberduck"
      "vlc"
    ];
    masApps = {
      Xcode = 497799835;
    };
  };
}
