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
      "arc"
      "coconutbattery"
      "cyberduck"
      "orion"
      "proxyman"
      "vlc"
      "zen"
    ];
    masApps = {
      "Slack" = 803453959;
    };
  };
}
