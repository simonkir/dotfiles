;;; -*- lexical-binding: t; -*-

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
