{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
      "LizardByte/homebrew"
      "homebrew/services"
    ];
    brews = [ ];
    casks = [
      "1password"
      "arc"
      "coconutbattery"
      "cyberduck"
      "docker"
      "vlc"
    ];
    masApps = {
      Xcode = 497799835;
    };
  };
}
