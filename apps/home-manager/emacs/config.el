;; Remove UI clutter
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq use-file-dialog nil)
(setq default-frame-alist '(
  (undecorated . t)
  (internal-border-width . 10)))

;; Terminal
(defun my-term ()
  (interactive)
  (term "/run/current-system/sw/bin/zsh"))

;; Line number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Evil mode
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)

;; Evil collection (for ibuffer and other modes)
(require 'evil-collection)
(evil-collection-init)

;; General.el for keybindings
(require 'general)

;; Define leader key
(general-create-definer my-leader-def
  :states '(normal visual emacs)
  :keymaps 'override
  :prefix "SPC"
  :global-prefix "SPC")

;; Buffer keybindings
(my-leader-def
  "b" '(:ignore t :which-key "Buffer")
  "bb" '(switch-to-buffer :which-key "Switch buffer")
  "bk" '(kill-buffer :which-key "Kill buffer")
  "bi" '(ibuffer :which-key "Ibuffer"))

;; Emulate Mx
(my-leader-def
  "\:" '(helm-M-x :which-key "Execute command"))

;; Window keybindings
(my-leader-def
  "w" '(:ignore t :which-key "Window")
  "wh" '(evil-window-left :which-key "Window left")
  "wj" '(evil-window-down :which-key "Window down")
  "wk" '(evil-window-up :which-key "Window up")
  "wl" '(evil-window-right :which-key "Window right")
  "ws" '(:ignore t :which-key "Split window")
  "wsh" '(evil-window-split :which-key "Split window horizontally")
  "wsv" '(evil-window-vsplit :which-key "Split window vertically")
  "wq" '(evil-window-delete :which-key "Close window"))

;; File keybindings
(my-leader-def
  "f" '(:ignore t :which-key "File")
  "fs" '(save-buffer :which-key "Save file")
  "ff" '(helm-projectile-find-file :which-key "Find file"))

;; Search keybindings
(my-leader-def
  "s" '(:ignore t :which-key "Search")
  "st" '(helm-projectile-rg :which-key "Search Text"))

;; Treemacs keybindings
(my-leader-def
  "<tab>" '(treemacs-select-window :which-key "Treemacs"))

;; Quit keybindings
(my-leader-def
  "q" '(:ignore t :which-key "Quit")
  "qq" '(save-buffers-kill-terminal :which-key "Quit Emacs")
  "qw" '(save-buffers-kill-emacs :which-key "Save and quit"))

;; Terminal keybinding
(my-leader-def
  "t" '(my-term :which-key "Terminal"))

;; Git keybindings
(my-leader-def
  "g" '(:ignore t :which-key "Git")
  "gg" '(magit :which-key "Magit"))

;; LSP keybindings
(my-leader-def
  "l" '(:ignore t :which-key "LSP")
  "lc" '(evilnc-comment-or-uncomment-lines :which-key "Comment out lines")
  "lff" '(lsp-format-buffer :which-key "Format file"))

;; Font settings
(set-face-attribute 'default nil :font "MonaspiceNe Nerd Font Propo" :height 130)
(set-face-attribute 'fixed-pitch nil :font "MonaspiceNe Nerd Font Propo" :height 130)
(set-face-attribute 'variable-pitch nil :font "MonaspiceNe Nerd Font Propo" :height 130 :weight 'regular)

;; Doom Emacs start screen
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-projects-backend 'projectile)
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-items '((recents  . 10)
			(projects . 5)))

;; Dracula theme
(require 'dracula-theme)
(load-theme 'dracula t)

;; All-the-icons
(require 'all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'ibuffer-mode-hook #'all-the-icons-ibuffer-mode)

;; Doom modeline
(require 'doom-modeline)
(doom-modeline-mode 1)
(setq doom-modeline-height 20)
(setq doom-modeline-bar-width 0)
(setq doom-modeline-total-line-number t)
(setq doom-modeline-vcs-max-length 10)
(setq doom-modeline-lsp t)
(setq doom-modeline-modal t)
(setq doom-modeline-modal-icon t)
(setq doom-modeline-modal-modern-icon t)

;; Which-key
(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.25)

;; Helm
(require 'helm)
(require 'helm-autoloads)
(require 'helm-themes)
(require 'helm-projectile)
(helm-mode 1)

;; Tree-sitter
(require 'treesit)
(require 'nix-mode)
(require 'treesit-auto)
(customize-set-variable 'treesit-auto-install 'prompt)
(treesit-auto-add-to-auto-mode-alist 'all)
(global-treesit-auto-mode)

;; LSP
(require 'lsp-mode)
(add-hook 'after-save-hook 'lsp-format-buffer)
(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
(require 'lsp-ui)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-position 'at-point) 
(setq lsp-ui-sideline-show-diagnostics t) 
(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-sideline-delay 0)
(add-hook 'nix-mode-hook #'lsp)
(add-hook 'rust-ts-mode-hook #'lsp)
(setq lsp-rust-server 'rust-analyzer)
(setq lsp-nix-server 'nil)
(setq lsp-ui-sideline-show-diagnostics 1)
(setq lsp-ui-sideline-delay 0.25)
(setq lsp-nix-nil-formatter ["nixfmt"])

;; Company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.15)

;; Projectile
(projectile-mode +1) 

;; Centaur Tabs
(require 'centaur-tabs)
(centaur-tabs-mode t)
(setq centaur-tabs-style "bar"
      centaur-tabs-set-icons t
      centaur-tabs-height 32
      centaur-tabs-set-close-button nil
      centaur-tabs-set-modified-marker t)
(centaur-tabs-group-by-projectile-project)

;; Treemacs
(require 'treemacs)
(require 'treemacs-all-the-icons)
(require 'treemacs-projectile)
(require 'treemacs-all-the-icons)
(treemacs-load-theme "all-the-icons")
(treemacs-project-follow-mode t)
(setq treemacs-width 30
      treemacs-space-between-root-nodes nil
      treemacs-indentation 1
      treemacs-indentation-string " "
      treemacs-is-never-other-window t
      treemacs-silent-refresh t
      treemacs-silent-filewatch t
      treemacs-expand-after-init t
      treemacs-width-is-initially-locked nil
      treemacs-show-hidden-files t
      treemacs-never-persist nil
      treemacs-file-follow-delay 0.1
      treemacs-goto-tag-strategy 'refetch-index
      treemacs-collapse-dirs 0)

(setq treemacs-display-in-side-window t
      treemacs-position 'left
      treemacs-show-cursor nil
      treemacs-use-all-the-icons-theme t
      treemacs-icon-size 12)
(add-hook 'treemacs-mode-hook (lambda () (display-line-numbers-mode -1)))

;; Magit fullscreen
(setq magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
