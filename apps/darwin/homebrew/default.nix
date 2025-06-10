{ ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "uninstall";
      upgrade = true;
      autoUpdate = true;
    };
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
