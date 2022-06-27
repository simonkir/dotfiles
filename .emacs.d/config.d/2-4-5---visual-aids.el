;;; -*- lexical-binding: t; -*-



; parentheses ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(show-paren-mode)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))



; writing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :general
  ('normal 'override :prefix "SPC t"
    "v" 'visual-fill-column-mode
    "V" 'set-fill-column)

  :config (setq-default visual-fill-column-center-text t))



; text scale
(general-def '(normal visual) 'override :prefix "SPC"
  "0" 'text-scale-adjust
  "+" 'text-scale-adjust
  "-" 'text-scale-adjust)



; indent guides ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-indent-guides
  :hook (prog-mode . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'bitmap))
