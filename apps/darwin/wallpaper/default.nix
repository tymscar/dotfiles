{ pkgs, lib, ... }:

let
  originalWallpaper = builtins.fetchurl {
    url = "https://trisquel.info/files/tile.png";
    sha256 = "sha256:1n5wwm3mafhsl1j57nkx410c6gas1h2qw4m9yh44j8qza2c68h1g";
  };
  tiledWallpaper = pkgs.stdenv.mkDerivation {
    name = "tiled-wallpaper";
    buildInputs = [ pkgs.imagemagick ];
    src = originalWallpaper;
    buildCommand = ''
      mkdir -p $out
      convert $src -set option:distort:viewport 3024x1964 -virtual-pixel tile -filter point -distort SRT 0 +repage $out/internal-wallpaper.png
      convert $src -set option:distort:viewport 3440x1440 -virtual-pixel tile -filter point -distort SRT 0 +repage $out/external-wallpaper.png
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-x9W3P1IYQTStxARQucMkgP25SCe9nI3bDBwfslXTgD4=";
  };

  colourHex = "#008180";
  colourWallpaper = pkgs.stdenv.mkDerivation {
    name = "colour-wallpaper";
    buildInputs = [ pkgs.imagemagick ];
    buildCommand = ''
      mkdir -p $out
      magick -size 1x1 xc:${colourHex} $out/solid-color.png
      magick $out/solid-color.png -resize 3024x1964! $out/internal-wallpaper.png
      magick $out/solid-color.png -resize 3440x1440! $out/external-wallpaper.png
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "sha256-hg1fF0m2m6SGfVMOoVN3NQ8uPtIRv4yxGS61HZr9IN0=";
  };

  selectedWallpaper = colourWallpaper;
in {
  home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    resolutions=$(/usr/sbin/system_profiler SPDisplaysDataType | /usr/bin/awk '/Resolution/{print $2 " x " $4}')
    internalScreen="3024 x 1964"
    externalScreen="3440 x 1440"
    internalWallpaper="${selectedWallpaper}/internal-wallpaper.png"
    externalWallpaper="${selectedWallpaper}/external-wallpaper.png"
    index=1
    echo "$resolutions" | while read -r resolution; do
      if [[ "$resolution" == *"$internalScreen"* ]]; then
        /usr/bin/osascript -e "tell application \"System Events\" to set picture of desktop $index to POSIX file \"$internalWallpaper\""
      elif [[ "$resolution" == *"$externalScreen"* ]]; then
        /usr/bin/osascript -e "tell application \"System Events\" to set picture of desktop $index to POSIX file \"$externalWallpaper\""
      fi
      ((index++))
    done
  '';
}
