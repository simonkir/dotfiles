;;; -*- lexical-binding: t; -*-



(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))) ;; emacsclient defaults to *scratch*

(use-package dashboard
  :demand t
  :ensure t

  :custom
  (dashboard-items             '((bookmarks . 10) (recents . 10)))
  (dashboard-startup-banner    'logo)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons    t)
  (dashboard-center-content    t)

  :config
  (dashboard-setup-startup-hook))
