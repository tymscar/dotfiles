{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      dracula-theme.theme-dracula
      vscodevim.vim
    ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "window.titleBarStyle" = "custom";
      "vim.useSystemClipboard" = true;
      "vim.leader" = "<space>";
    };
  };
}




