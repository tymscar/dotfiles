{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
    ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "window.titleBarStyle" = "custom";
    };
  };
}

