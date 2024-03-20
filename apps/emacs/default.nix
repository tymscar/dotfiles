{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraConfig = builtins.readFile ./config.el;
    extraPackages = epkgs: with epkgs;[
      all-the-icons
      all-the-icons-dired
      all-the-icons-ibuffer
      catppuccin-theme
      company
      dashboard
      evil
      evil-collection
      general
      helm
      helm-company
      helm-themes
      lsp-mode
      lsp-ui
      magit
      nix-mode
      spaceline-all-the-icons
      treesit-auto
      treesit-grammars.with-all-grammars
      which-key
    ]; 
  };
  home.packages = with pkgs; [
    emacs-all-the-icons-fonts
    nil
  ];
}
