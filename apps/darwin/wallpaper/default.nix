{ pkgs, lib, ... }:

let
  originalWallpaper = builtins.fetchurl {
    url = "https://cdn.osxdaily.com/wp-content/uploads/2017/12/classic-mac-os-tile-wallpapers-4.png";
    sha256 = "sha256:1mf6298l74ll251z2qrr9ld5mzn4ncgdr4sg5gz6h8sd39pzj5wz";
  };
  tiledWallpaper = pkgs.stdenv.mkDerivation {
    name = "tiled-wallpaper";
    buildInputs = [ pkgs.imagemagick ];
    src = originalWallpaper;
    buildCommand = ''
      mkdir -p $out
      convert $src -set option:distort:viewport 3024x1964 -virtual-pixel tile -filter point -distort SRT 0 +repage $out/tiled-wallpaper.png
    '';
    outputHashMode = "recursive";
    outputHashAlgo = "sha256";
    outputHash = "7MjD6AXVUD39IKlYkWY0tVsDRLrUgLPlnGWN0mjOTOA=";
  };
in {
  home.activation.setWallpaper = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /usr/bin/osascript -e 'tell application "System Events" to tell every desktop to set picture to "${tiledWallpaper}/tiled-wallpaper.png"'
  '';
}
