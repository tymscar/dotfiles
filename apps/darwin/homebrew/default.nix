{ pkgs, lib, ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [ ];
    brews = [ ];
    casks = [ "1password" "blender" "brave-browser" "discord" ];
    masApps = { Xcode = 497799835; };
  };
}
