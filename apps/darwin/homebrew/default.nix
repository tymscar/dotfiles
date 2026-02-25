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
      "bambu-studio"
      "coconutbattery"
      "cyberduck"
      "opencode-desktop"
      "orion"
      "proxyman"
      "vlc"
    ];
    masApps = { };
  };
}
