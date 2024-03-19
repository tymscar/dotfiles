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
  "\:" '(execute-extended-command :which-key "Execute command"))

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
  "ff" '(find-file :which-key "Find file"))

;; Quit keybindings
(my-leader-def
  "q" '(:ignore t :which-key "Quit")
  "qq" '(save-buffers-kill-terminal :which-key "Quit Emacs")
  "qw" '(save-buffers-kill-emacs :which-key "Save and quit"))

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

