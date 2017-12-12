(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
	     '("elpy" . "https://jorgeschaefer.github.io/packages/"))

(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3eb2b5607b41ad8a6da75fe04d5f92a46d1b9a95a202e3f5369e2cdefb7aac5c" default)))
 '(package-selected-packages
   (quote
    (molokai-theme google company flycheck projectile evil 2048-game gruvbox-theme helm)))
 '(safe-local-variable-values
   (quote
    ((projectile-project-run-cmd . "./Build/")
     (projectile-project-compilation-cmd . "g++ lol.cpp")
     (projectile-project-compilation-dir . "")
     (projectile-project-run-cmd . "./Build/opgl")
     (projectile-project-compilation-cmd . "make -k")
     (projectile-project-compilation-dir . "Build/")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Helm
(require 'helm-config)
(helm-mode 1)
(setq helm-split-window-in-side-p 1)

(setq helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match t
      helm-apropos-fuzzy-match t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-h a") 'helm-apropos)
(global-set-key (kbd "C-h b") 'helm-descbinds)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x c SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-x c r") 'helm-register)
(global-set-key (kbd "C-x c ,") 'helm-calcul-expression)
(global-set-key (kbd "C-x c f") 'helm-find)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(set 'custom-safe-themes t)
(load-theme 'molokai)

(tool-bar-mode 0)
(menu-bar-mode 0)
(global-linum-mode 1)
(setq column-number-mode t)
(setq inhibit-startup-screen t)
(require 'evil)
(evil-mode 1)

(require 'helm-projectile)
(projectile-global-mode)
(helm-projectile-on)
(setq projectile-enable-caching t)

(define-key projectile-mode-map (kbd "C-c p s") 'helm-projectile-grep)

;; Company
(require 'company)
(setq company-idle-delay 0.0)
(setq company-minimum-prefix-length 1)

;; Allman style
(setq c-default-style "bsd"
      c-basic-offset 4)

(require 'cc-mode)
(add-hook 'c-mode-common-hook 'flycheck-mode)
(add-hook 'c-mode-common-hook 'company-mode)

(define-key c++-mode-map (kbd "C-M-i") 'company-complete)
