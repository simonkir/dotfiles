;;; -*- lexical-binding: t; -*-



(use-package magit
  :general (general-def-leader
    "g" 'magit-file-dispatch
    "G" 'magit-dispatch)

  :config
  (add-hook 'git-commit-setup-hook 'meow-insert)

  (general-def magit-diff-mode-map
    "C-<tab>" 'sk:next-buffer
    "C-<backtab>" 'sk:previous-buffer)
  
  (general-def magit-mode-map
    "<backtab>" 'magit-section-cycle-diffs
    "<tab>" 'magit-section-toggle
    "TAB" 'magit-section-toggle
    "g" 'nil
    "g r" 'magit-refresh
    "x" 'magit-delete-thing
    "p" 'magit-push))
