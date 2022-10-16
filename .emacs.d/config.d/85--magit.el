;;; -*- lexical-binding: t; -*-



(use-package magit
  :general (general-def-leader
    "SPC g" 'magit-file-dispatch
    "SPC G" 'magit-dispatch)

  :config
  (add-hook 'git-commit-setup-hook 'meow-insert)
  
  (general-def magit-mode-map
    "<backtab>" 'magit-section-cycle-diffs
    "<tab>" 'magit-section-toggle
    "TAB" 'magit-section-toggle
    "g" 'nil
    "g r" 'magit-refresh
    "x" 'magit-delete-thing
    "p" 'magit-push))
