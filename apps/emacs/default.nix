{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraConfig = builtins.readFile ./config.el;
    extraPackages = epkgs: with epkgs;[
      evil
      general
      which-key
      magit
      catppuccin-theme
      all-the-icons
      evil-collection
      dashboard
      spaceline-all-the-icons
      all-the-icons-dired
      all-the-icons-ibuffer
    ];
  };
}
