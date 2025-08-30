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
    brews = [
      "opencode"
    ];
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
