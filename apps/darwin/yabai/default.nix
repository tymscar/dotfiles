{ pkgs, ... }:
let
  myNixpkgs = pkgs.fetchFromGitHub {
    owner = "tymscar";
    repo = "nixpkgs";
    rev = "yabaiHead";
    sha256 = "sha256-nHdTda+unoMmjfuTSXKkBe672BNMsLNjNOjitwMcwJM=";
  };
  myOverlay = final: prev: {
    yabai = final.callPackage (myNixpkgs + "/pkgs/os-specific/darwin/yabai") { };
  };
  myPkgs = import pkgs.path {
    inherit (pkgs) system;
    overlays = [ myOverlay ];
  };
in
{
  services.yabai = {
    enable = true;
    extraConfig = builtins.readFile ./yabairc;
    package = myPkgs.yabai;
  };
}
