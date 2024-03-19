{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
      (pkgs.catppuccin-vsc.override { accent = "red"; })
    ];
    userSettings = {
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "window.titleBarStyle" = "custom";
    };
  };
}

