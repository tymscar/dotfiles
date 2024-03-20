;; Remove UI clutter
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq use-file-dialog nil)
(setq default-frame-alist '(
  (undecorated . t)
  (internal-border-width . 10)))

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
  "ff" '(helm-find-files :which-key "Find file"))

;; Quit keybindings
(my-leader-def
  "q" '(:ignore t :which-key "Quit")
  "qq" '(save-buffers-kill-terminal :which-key "Quit Emacs")
  "qw" '(save-buffers-kill-emacs :which-key "Save and quit"))

;; Git keybindings
(my-leader-def
  "g" '(:ignore t :which-key "Git")
  "gg" '(magit :which-key "Magit"))

;; LSP keybindings
(my-leader-def
  "l" '(:ignore t :which-key "LSP")
  "lff" '(lsp-format-buffer :which-key "Format file"))

;; Font settings
(set-face-attribute 'default nil :font "JetBrains Mono Nerd Font" :height 130)
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono Nerd Font" :height 130)
(set-face-attribute 'variable-pitch nil :font "JetBrains Mono Nerd Font" :height 130 :weight 'regular)


;; Doom Emacs start screen
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-items '((recents  . 10)))

;; Doom themes
(require 'catppuccin-theme)
(load-theme 'catppuccin t)

;; All-the-icons
(require 'all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'ibuffer-mode-hook #'all-the-icons-ibuffer-mode)

;; Spaceline
(require 'spaceline-all-the-icons) 
(setq spaceline-all-the-icons-separator-type 'none)
(setq spaceline-all-the-icons-spacer-size 0)
(set-face-attribute 'mode-line nil :height 100)
(set-face-attribute 'mode-line-inactive nil :height 100)
(spaceline-all-the-icons-theme)

;; Which-key
(require 'which-key)
(which-key-mode)
(setq which-key-idle-delay 0.25)

;; Helm
(require 'helm)
(require 'helm-autoloads)
(require 'helm-themes)
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
(setq lsp-nix-nil-formatter ["nixpkgs-fmt"])

;; Company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.15)
