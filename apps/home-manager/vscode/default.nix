{ nix-vscode-extensions, ... }:

let extensions-marketplace = nix-vscode-extensions.vscode-marketplace;
in {
  programs.vscode = {
    enable = true;
    extensions = with extensions-marketplace; [
      bbenoist.nix
      dracula-theme.theme-dracula
      vscodevim.vim
      koog1000.fossil
    ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "window.titleBarStyle" = "custom";
      "vim.useSystemClipboard" = true;
      "vim.leader" = "<space>";
    };
  };
}

