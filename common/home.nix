{ config, pkgs, ... }:

{
  imports = [
    ../apps/home-manager/git
    ../apps/home-manager/lazygit
    ../apps/home-manager/neovim
    ../apps/home-manager/gpg
    ../apps/home-manager/zsh
    ../apps/home-manager/atuin
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "mauve";
    # apps/home-manager/tmux
    tmux.enable = false;
    # apps/home-manager/neovim
    nvim.enable = false;
    # apps/home-manager/polybar/config.ini
    polybar.enable = false;
  };

  programs.bat.enable = true;
  programs.lsd.enable = true;

  home.sessionVariables.BAT_THEME = config.programs.bat.config.theme or "";

  home.packages = with pkgs; [
    man-pages
    man-pages-posix
    tree
    ripgrep
    gnupg
    gotop
    htop
    fastfetch
    nixfmt
    p7zip
    cmatrix
    cargo
    rust-analyzer
  ];

  manual.manpages.enable = false;

  home.stateVersion = "22.11";
}
