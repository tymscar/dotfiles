(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq use-file-dialog nil)
(setq default-frame-alist '((internal-border-width . 10)))

;; Line number
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

;; Evil mode
(setq evil-want-keybinding nil)
(evil-mode 1)

;; Evil collection (for ibuffer and other modes)
(evil-collection-init)

;; Define leader key
(general-create-definer
 my-leader-def
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC"
 :global-prefix "SPC")

;; Buffer keybindings
(defun my-format-buffer ()
  "Format the current buffer. Use `elisp-format-buffer` for Emacs Lisp mode, otherwise use `lsp-format-buffer`."
  (interactive)
  (if (derived-mode-p 'emacs-lisp-mode)
      (elisp-autofmt-buffer)
    (lsp-format-buffer)))

(my-leader-def
 "b"
 '(:ignore t :which-key "Buffer")
 "bb"
 '(switch-to-buffer :which-key "Switch buffer")
 "bk"
 '(kill-buffer :which-key "Kill buffer")
 "bf"
 '(my-format-buffer :which-key "Format buffer")
 "bi"
 '(ibuffer :which-key "Ibuffer"))

;; Emulate Mx
(my-leader-def "\:" '(helm-M-x :which-key "Execute command"))

;; Window keybindings
(my-leader-def
 "w"
 '(:ignore t :which-key "Window")
 "wh"
 '(evil-window-left :which-key "Window left")
 "wj"
 '(evil-window-down :which-key "Window down")
 "wk"
 '(evil-window-up :which-key "Window up")
 "wl"
 '(evil-window-right :which-key "Window right")
 "ws"
 '(:ignore t :which-key "Split window")
 "wsh"
 '(evil-window-split :which-key "Split window horizontally")
 "wsv"
 '(evil-window-vsplit :which-key "Split window vertically")
 "wq"
 '(evil-window-delete :which-key "Close window"))

;; File keybindings
(my-leader-def
 "f"
 '(:ignore t :which-key "File")
 "fs"
 '(save-buffer :which-key "Save file")
 "ff"
 '(helm-projectile-find-file :which-key "Find file"))

;; Search keybindings
(my-leader-def
 "s"
 '(:ignore t :which-key "Search")
 "st"
 '(helm-projectile-rg :which-key "Search Text"))

;; Quit keybindings
(my-leader-def
 "q"
 '(:ignore t :which-key "Quit")
 "qq"
 '(save-buffers-kill-terminal :which-key "Quit Emacs")
 "qw"
 '(save-buffers-kill-emacs :which-key "Save and quit"))

;; Git keybindings
(my-leader-def
 "g" '(:ignore t :which-key "Git") "gg" '(magit :which-key "Magit"))

;; LSP keybindings
(my-leader-def
 "l"
 '(:ignore t :which-key "LSP")
 "lc"
 '(evilnc-comment-or-uncomment-lines :which-key "Comment out lines")
 "lff"
 '(lsp-format-buffer :which-key "Format file"))

;; Font settings
(set-face-attribute 'default nil
                    :font "MonaspiceNe Nerd Font Propo"
                    :height 130)
(set-face-attribute 'fixed-pitch nil
                    :font "MonaspiceNe Nerd Font Propo"
                    :height 130)
(set-face-attribute 'variable-pitch nil
                    :font "MonaspiceNe Nerd Font Propo"
                    :height 130
                    :weight 'regular)

;; Fix tab width
(setq-default tab-width 2)

;; Doom Emacs start screen
(dashboard-setup-startup-hook)
(setq dashboard-projects-backend 'projectile)
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-items '((recents . 10) (projects . 5)))

;; Dracula theme
(load-theme 'dracula t)

;; All-the-icons
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'ibuffer-mode-hook #'all-the-icons-ibuffer-mode)

;; Doom modeline
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
(which-key-mode)
(setq which-key-idle-delay 0.25)

;; Helm
(helm-mode 1)

;; Tree-sitter
(customize-set-variable 'treesit-auto-install 'prompt)

;; LSP
(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-position 'at-point)
(setq lsp-ui-sideline-show-diagnostics t)
(setq lsp-ui-sideline-show-hover t)
(setq lsp-ui-sideline-delay 0)
(add-hook 'nix-mode-hook #'lsp)
(add-hook 'rust-ts-mode-hook #'lsp)
(add-hook 'typescript-ts-mode-hook #'lsp)
(add-hook 'tsx-ts-mode-hook #'lsp)
(setq lsp-rust-server 'rust-analyzer)
(setq lsp-nix-server 'nil)
(setq lsp-ui-sideline-show-diagnostics 1)
(setq lsp-ui-sideline-delay 0.25)
(setq lsp-nix-nil-formatter ["nixfmt"])
(setq lsp-clients-typescript-server-args '("--stdio"))
(setq lsp-clients-typescript-server "typescript-language-server")
(setq lsp-clients-typescript-tls-path "typescript-language-server")
(setq lsp-typescript-format-enable t)
(setq lsp-enable-which-key-integration t)

;; Company
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1)
(setq company-idle-delay 0.15)

;; Projectile
(projectile-mode +1)

;; Centaur Tabs
(centaur-tabs-mode t)
(setq
 centaur-tabs-style "bar"
 centaur-tabs-set-icons t
 centaur-tabs-height 32
 centaur-tabs-set-close-button nil
 centaur-tabs-set-modified-marker t)
(centaur-tabs-group-by-projectile-project)

;; Magit fullscreen
(setq magit-display-buffer-function
      'magit-display-buffer-same-window-except-diff-v1)

