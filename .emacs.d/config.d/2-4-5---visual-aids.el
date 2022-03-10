;;; -*- lexical-binding: t; -*-



; parentheses ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(show-paren-mode)

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))



; wrting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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



; font settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-face-attribute 'default nil :family "Source Code Pro" :height 100)
(set-face-attribute 'fixed-pitch nil :family "Source Code Pro")
(set-face-attribute 'variable-pitch nil :family "Noto Serif")

(use-package mixed-pitch
  :ensure t
  :hook ((org-mode TeX-mode) . mixed-pitch-mode)
  :general ('normal 'override "SPC t m" 'mixed-pitch-mode)
  :config (setq mixed-pitch-variable-pitch-cursor nil)) ;; keep filled cursor
