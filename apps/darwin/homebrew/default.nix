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
      "sst/tap"
    ];
    brews = [ ];
    casks = [
      "1password"
      "coconutbattery"
      "cyberduck"
      "proxyman"
      "vlc"
    ];
    masApps = { };
  };
}
