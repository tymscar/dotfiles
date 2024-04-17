{ specialArgs, ... }:

let
  switchCommand = if specialArgs.os == "linux" then
    "sudo nixos-rebuild switch --flake '.#${specialArgs.device}'"
  else
    "nix run nix-darwin -- switch --flake '.#${specialArgs.device}'";
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra = if specialArgs.os == "darwin" then
      "export PATH=/Users/tymscar/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
    else
      "";
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker-compose" "docker" "git" ];
      theme = "lambda";
    };
    shellAliases = {
      ls = "lsd";
      cat = "bat";
      vim = "nvim";
      switch = switchCommand;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
