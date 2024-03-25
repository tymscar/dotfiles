{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    extraConfig = builtins.readFile ./config.el;
    extraPackages = epkgs:
      with epkgs; [
        all-the-icons
        all-the-icons-dired
        all-the-icons-ibuffer
        company
        dashboard
        doom-modeline
        dracula-theme
        evil
        evil-collection
        evil-nerd-commenter
        general
        helm
        helm-company
        helm-projectile
        helm-rg
        helm-themes
        lsp-mode
        lsp-ui
        magit
        nix-mode
        projectile
        treesit-auto
        treesit-grammars.with-all-grammars
        which-key
      ];
  };
  home.packages = with pkgs; [ emacs-all-the-icons-fonts nil nixfmt ];
}
