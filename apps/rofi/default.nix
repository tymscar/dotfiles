{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = builtins.toPath ./dracula.rasi;
  };
}
