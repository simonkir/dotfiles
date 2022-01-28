;;; -*- lexical-binding: t; -*-



(use-package magit
  :ensure t
  :general ('normal 'override "SPC g" 'magit-file-dispatch)
  :config (add-hook 'git-commit-mode-hook 'evil-insert-state))
