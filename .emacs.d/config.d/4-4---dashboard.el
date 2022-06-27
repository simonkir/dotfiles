;;; -*- lexical-binding: t; -*-



(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))) ;; emacsclient defaults to *scratch*

(use-package dashboard
  :demand t
  :config
  (setq dashboard-items             '((bookmarks . 10) (recents . 10)))
  (setq dashboard-startup-banner    'logo)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons    t)
  (setq dashboard-center-content    t)
  (dashboard-setup-startup-hook))
