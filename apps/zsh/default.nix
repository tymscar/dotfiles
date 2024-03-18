{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" "git" ];
      theme = "lambda";
    };
    shellAliases = {
      ls = "lsd";
      cat = "bat";
      vim = "nvim";
      switch = "sudo nixos-rebuild switch --flake '.#bender'";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
