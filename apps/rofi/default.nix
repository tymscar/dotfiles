{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = builtins.toPath ./catppuccin-mocha.rasi;
  };
}
