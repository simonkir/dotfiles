;;; -*- lexical-binding: t; -*-



(use-package magit
  :bind (:map mode-specific-map
    ("g" . magit-file-dispatch)
    ("G" . magit-dispatch))

  :config
  (bind-keys :map magit-mode-map
    ("<backtab>" . magit-section-cycle-diffs)))
