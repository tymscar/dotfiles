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
      "proxyman"
      "vlc"
    ];
    masApps = { };
  };
}
