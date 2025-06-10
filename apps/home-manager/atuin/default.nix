{ pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      dialect = "uk";
      sync_address = "https://atuin.tymscar.com";
      sync_frequency = "0"; # This means sync after every command. I own the server, so I don't mind.
      exit_mode = "return-query";
      keymap_mode = "vim-insert";
    };
  };

  programs.zsh.initContent = ''
    zvm_after_init_commands+=('eval "$(atuin init zsh --disable-up-arrow)"')
  '';
}
