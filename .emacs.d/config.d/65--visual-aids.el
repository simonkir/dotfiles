;;; -*- lexical-binding: t; -*-



; writing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package visual-fill-column
  :bind (:map sk:leader-map
    ("t v" . visual-fill-column-mode)
    ("t V" . set-fill-column))

  :config (setq-default visual-fill-column-center-text t))



; text scale ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(bind-keys :map sk:leader-map
  ("0" . text-scale-adjust)
  ("+" . text-scale-adjust)
  ("-" . text-scale-adjust))



; indent guides ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package highlight-indent-guides
  :hook ((prog-mode org-mode LaTeX-mode) . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'bitmap))
