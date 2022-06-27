;;; -*- lexical-binding: t; -*-



; parentheses ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(show-paren-mode)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))



; writing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :ensure t
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
  :defer t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'bitmap))
