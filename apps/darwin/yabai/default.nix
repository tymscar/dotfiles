{ pkgs, ... }:

{
  services.yabai = {
    enable = true;
    extraConfig = builtins.readFile ./yabairc;
  };
}
