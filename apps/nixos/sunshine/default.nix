{ pkgs, ... }:

let
  image = builtins.fetchurl {
    url =
      "https://cdn.osxdaily.com/wp-content/uploads/2017/12/classic-mac-os-tile-wallpapers-4.png";
    sha256 = "sha256:1mf6298l74ll251z2qrr9ld5mzn4ncgdr4sg5gz6h8sd39pzj5wz";
  };
  pinnedSunshine = (import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "56aeedf456e676d46af2595c3f66de9cf95f2cdd";
    sha256 = "sha256-4BWzdTzfgQIv3kGInYJ5AtcahBUCIJBPEYu5nSnYSBk=";
  }) {
    config.allowUnfree = true;
    system = pkgs.system;
  }).sunshine;
  connectionScript = pkgs.writeShellScriptBin "script" ''
    export DISPLAY=:0
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 2796x1290 --rate 140
  '';
  disconnectionScript = pkgs.writeShellScriptBin "script" ''
    export DISPLAY=:0
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 3440x1440 --rate 144
  '';
in {
  services = {
    sunshine = {
      enable = true;
      package = pinnedSunshine.override { cudaSupport = true; };
      openFirewall = true;
      capSysAdmin = true;
      settings = {
        sunshine_name = "❄️NixOS❄️";
        output_name = 1;
        resolutions = "[ 3440x1440 ]";
        fps = "[ 120 144 ]";
        encoder = "nvenc";
        nvenc_preset = 1;
        av1_mode = 1;
      };
      applications = {
        apps = [{
          name = "Desktop";
          image-path = "${image}";
          prep-cmd = [{
            do = "${connectionScript}/bin/script";
            undo = "${disconnectionScript}/bin/script";
          }];
          exclude-global-prep-cmd = "false";
          auto-detach = "true";
        }];
      };
    };
  };
}
