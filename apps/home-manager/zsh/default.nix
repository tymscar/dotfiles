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
    initContent =
      if specialArgs.os == "darwin" then
        ''
          export PATH=/Users/${accountUsername}/.local/bin:/Users/${accountUsername}/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH
          if [ -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
            . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
          fi
          nixpkgs() {
            local packages=()
            for pkg in "$@"; do
              packages+=("nixpkgs#$pkg")
            done
            nix shell "''${packages[@]}"
          }
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
      cat = "bat -p --theme 1337";
      vim = "nvim";
      switch = switchCommand;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
