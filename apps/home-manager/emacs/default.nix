{ pkgs, specialArgs, ... }:

{
  programs.emacs = {
    enable = true;
    package =
      if specialArgs.os == "linux" then pkgs.emacs else pkgs.emacsMacport;

    extraConfig = builtins.readFile ./config.el;
    extraPackages = epkgs:
      with epkgs; [
        all-the-icons
        all-the-icons-dired
        all-the-icons-ibuffer
        centaur-tabs
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
        treemacs
        treemacs-all-the-icons
        treemacs-evil
        treemacs-projectile
        which-key
      ];
  };
  home.packages = with pkgs; [ emacs-all-the-icons-fonts nil nixfmt-classic ];
}
