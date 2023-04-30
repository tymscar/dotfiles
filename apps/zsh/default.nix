{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" "git" ];
      theme = "lambda";
    };
    shellAliases = {
      ls = "lsd";
      cat = "bat";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}