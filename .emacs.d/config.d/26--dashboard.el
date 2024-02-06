;;; -*- lexical-binding: t; -*-



(setq initial-buffer-choice #'(lambda () (get-buffer "*dashboard*"))) ;; emacsclient defaults to *scratch*

(use-package dashboard
  :demand t
  :config
  (setq dashboard-banner-logo-png   "~/.emacs.d/logos/xemacs_color.png")
  ;;(setq dashboard-items             '((recentf . 15)))
  (setq dashboard-items             nil)
  (setq dashboard-startup-banner    'logo)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons    t)
  (setq dashboard-center-content    t)

  (dashboard-setup-startup-hook)
  (add-hook 'server-after-make-frame-hook
            #'(lambda ()
                (let ((dashboard-force-refresh t))
                  (dashboard-insert-startupify-lists)))))
