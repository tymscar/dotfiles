{
  pkgs,
  ...
}:

{
  programs.lazygit = {
    enable = true;
    settings = {
      customCommands = [
        {
          key = "i";
          context = "files";
          command = "nvim +Neogit";
          description = "Open git review in neovim";
          output = "terminal";
        }
      ];
      git = {
        pagers = [
          {
            pager = "${pkgs.delta}/bin/delta --dark --paging=never --true-color always --line-numbers";
          }
        ];
      };
      gui = {
        scrollHeight = 4;
        sidePanelWidth = 0.25;
        nerdFontsVersion = "3";
        showCommandLog = false;
      };
      disableStartupPopups = true;
      keybinding.files.ignoreFile = "I";
    };
  };
}
