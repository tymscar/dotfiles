{ pkgs, specialArgs, ... }:

{
  home.packages = with pkgs; [
    (emacsWithPackagesFromUsePackage {
      config = ./config.el;
      defaultInitFile = true;
      package = if specialArgs.os == "linux" then emacs else nur.repos.natsukium.emacs-plus;
      alwaysEnsure = false;
      alwaysTangle = false;
      extraEmacsPackages =
        epkgs: with epkgs; [
          all-the-icons
          all-the-icons-dired
          all-the-icons-ibuffer
          centaur-tabs
          company
          dashboard
          doom-modeline
          dracula-theme
          elisp-autofmt
          evil
          evil-collection
          evil-nerd-commenter
          general
          helm
          helm-company
          helm-projectile
          helm-rg
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
          nodePackages.typescript-language-server
          typescript
          emacs-all-the-icons-fonts
          nil
          python3
        ];
    })
  ];
}
