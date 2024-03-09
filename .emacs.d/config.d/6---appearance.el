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
;; display visual line numbers left of each buffer
(setq display-line-numbers-type 'visual)
(set-face-attribute 'line-number nil :foreground "#5b6268")
(global-display-line-numbers-mode 1)

; * text scale
(general-def-leader
  "0" 'text-scale-adjust
  "+" 'text-scale-adjust
  "-" 'text-scale-adjust)

; * dashboard
(use-package dashboard
  :demand t
  :config
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-banner-logo-png "~/.emacs.d/logos/mac256.png")

  (setq dashboard-center-content t)
  (setq dashboard-items '((bookmarks . 15)))

  ;;(setq dashboard-set-heading-icons t) ;; atm, there is an issue with oction definition
  (setq dashboard-set-file-icons t)
  (setq dashboard-icon-type 'nerd-icons)

  (setq initial-buffer-choice #'(lambda () (get-buffer "*dashboard*"))) ;; emacsclient defaults to *scratch*
  (dashboard-setup-startup-hook)
  (add-hook 'server-after-make-frame-hook
            #'(lambda ()
                (let ((dashboard-force-refresh t))
                  (dashboard-insert-startupify-lists)))))
