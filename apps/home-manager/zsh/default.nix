{
  pkgs,
  specialArgs,
  accountUsername,
  ...
}:

let
  switchCommand =
    if specialArgs.os == "linux" then
      "sudo nixos-rebuild switch --flake '.#${specialArgs.device}'"
    else
      "sudo nix run nix-darwin -- switch --flake '.#${specialArgs.device}'";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra =
      if specialArgs.os == "darwin" then
        ''
          export PATH=/Users/${accountUsername}/.local/bin:/Users/${accountUsername}/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH
          if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
            . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
          fi
        ''
      else
        "";
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker-compose"
        "docker"
        "git"
      ];
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
