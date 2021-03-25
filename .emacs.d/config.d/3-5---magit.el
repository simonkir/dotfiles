;;; -*- lexical-binding: t; -*-



(use-package magit
  :ensure t
  :config
  (add-hook 'git-commit-mode-hook 'evil-insert-state)

  :general ('normal 'override "SPC g" 'magit-file-dispatch))
