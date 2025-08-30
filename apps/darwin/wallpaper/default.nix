{ pkgs, lib, ... }:

let
  ultraWideWallpaper = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/o5/wallhaven-o5rj2m.jpg";
    sha256 = "sha256:1y9xwhlgxpzczcimb6zcvrs35mxym3hi8srhjn9zfw1b595i2kym";
  };

  macBookWallpaper = builtins.fetchurl {
    url = "https://w.wallhaven.cc/full/o5/wallhaven-o5rj2m.jpg";
    sha256 = "sha256:1y9xwhlgxpzczcimb6zcvrs35mxym3hi8srhjn9zfw1b595i2kym";
  };

  knownWallpapers = pkgs.stdenv.mkDerivation {
    name = "smart-wallpapers";
    buildInputs = [ pkgs.imagemagick ];
    buildCommand = ''
      mkdir -p $out/wallpapers

      convert ${ultraWideWallpaper} \
        -resize 3440x1440^ \
        -gravity center \
        -extent 3440x1440 \
        $out/wallpapers/3440x1440.png

      convert ${macBookWallpaper} \
        -resize 3024x1964^ \
        -gravity center \
        -extent 3024x1964 \
        $out/wallpapers/3024x1964.png
    '';
  };

  displayMonitorScript = pkgs.writeShellScript "display-monitor" ''
    set -euo pipefail

    current_displays=$(/usr/sbin/system_profiler SPDisplaysDataType | ${pkgs.gawk}/bin/awk '/Resolution/{print $2 "x" $4}')
    "${wallpaperApplierScript}" "$current_displays"
  '';

  wallpaperApplierScript = pkgs.writeShellScript "wallpaper-applier" ''
    set -euo pipefail

    KNOWN_WALLPAPERS="${knownWallpapers}/wallpapers"

    index=1
    while IFS= read -r resolution; do
      [[ -z "$resolution" ]] && continue
      
      if [[ -f "$KNOWN_WALLPAPERS/$resolution.png" ]]; then
        wallpaper_path="$KNOWN_WALLPAPERS/$resolution.png"
        /usr/bin/osascript -e "tell application \"System Events\" to tell desktop $index to set picture to POSIX file \"$wallpaper_path\"" 2>/dev/null || echo "Failed to set wallpaper for display $index"
        /usr/bin/osascript -e "tell application \"System Events\" to tell desktop $index to set picture scaling to fill screen" 2>/dev/null || true
      else
        echo "No wallpaper available for $resolution, skipping"
      fi
      
      ((index++))
    done <<< "$1"
  '';
in
{
  launchd.agents.wallpaper-monitor = {
    enable = true;
    config = {
      Label = "com.tymscar.wallpaper-monitor";
      ProgramArguments = [ "${displayMonitorScript}" ];
      WatchPaths = [ "/Library/Preferences/com.apple.windowserver.plist" ];
      RunAtLoad = true;
      KeepAlive = false;
      StandardOutPath = "/tmp/wallpaper-monitor.log";
      StandardErrorPath = "/tmp/wallpaper-monitor.log";
    };
  };

  home.activation.setInitialWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "Setting up initial wallpapers..."
    current_displays=$(/usr/sbin/system_profiler SPDisplaysDataType | /usr/bin/awk '/Resolution/{print $2 "x" $4}')
    ${wallpaperApplierScript} "$current_displays"
  '';
}
