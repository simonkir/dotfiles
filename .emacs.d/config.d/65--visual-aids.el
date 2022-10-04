;;; -*- lexical-binding: t; -*-



; writing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :general ('(normal visual) 'override
    "SPC t v" 'visual-fill-column-mode
    "SPC t V" 'set-fill-column)

  :config (setq-default visual-fill-column-center-text t))



; text scale ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def '(normal visual) 'override
  "SPC 0" 'text-scale-adjust
  "SPC +" 'text-scale-adjust
  "SPC -" 'text-scale-adjust)



; indent guides ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-indent-guides
  :hook ((prog-mode org-mode LaTeX-mode) . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'bitmap))
