;;; -*- lexical-binding: t; -*-



(use-package magit
  :ensure t
  :general
  ('(normal visual) 'override
    "SPC g" 'magit-file-dispatch
    "SPC G" 'magit-dispatch)

  :config
  (add-hook 'git-commit-mode-hook 'evil-insert-state)

  (general-def 'normal magit-mode-map
    "<backtab>" 'magit-section-cycle-diffs))
