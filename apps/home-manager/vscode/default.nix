{ nix-vscode-extensions, ... }:

let
  extensions-marketplace = nix-vscode-extensions.vscode-marketplace;
in
{
  programs.vscode = {
    enable = true;
    extensions = with extensions-marketplace; [
      bbenoist.nix
      dracula-theme.theme-dracula
      vscodevim.vim
      bruno-api-client.bruno
      mkhl.shfmt
      clinyong.vscode-css-modules
      ms-python.black-formatter
      editorconfig.editorconfig
      dbaeumer.vscode-eslint
      ms-azuretools.vscode-docker
      esbenp.prettier-vscode
      ms-python.vscode-pylance
      ms-python.python
    ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "window.titleBarStyle" = "custom";
      "vim.useSystemClipboard" = true;
      "vim.leader" = "<space>";
    };
  };
}
