;;; -*- lexical-binding: t; -*-

; * general settings
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(show-paren-mode 1)
(global-hl-line-mode 1)
(global-visual-line-mode 1)

; * line numbers
(use-package display-line-numbers
  :hook ((prog-mode text-mode help-mode conf-mode org-agenda-mode) . display-line-numbers-mode)
  :config
  (setq display-line-numbers-type 'visual)
  (set-face-attribute 'line-number nil :foreground "#5b6268"))

; * text scale
(general-def-leader
  "0" 'text-scale-adjust
  "+" 'text-scale-adjust
  "-" 'text-scale-adjust)

; * dashboard
(use-package dashboard
  :demand t
  :config
  (setq dashboard-items '((bookmarks . 15)))
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-banner-logo-png (expand-file-name (concat user-emacs-directory "logos/mac256.png")))

  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-type 'nerd-icons)
  ;;(setq dashboard-set-heading-icons t) ;; atm, there is an issue with oction definition

  ;; open dashboard when opening a new frame
  (dashboard-setup-startup-hook)
  (setq dashboard-force-refresh t) ;; always show icons
  (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))))
