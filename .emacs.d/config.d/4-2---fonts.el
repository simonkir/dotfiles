;;; -*- lexical-binding: t; -*-



; font settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(set-face-attribute 'default nil :family "Fira Code" :height 100)
;;(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 100)
(set-face-attribute 'default nil :family "Source Code Pro" :height 100)
(set-face-attribute 'fixed-pitch nil :family "Source Code Pro")
;;(set-face-attribute 'variable-pitch nil :family "Ubuntu")
(set-face-attribute 'variable-pitch nil :family "Noto Serif")



(use-package mixed-pitch
  :ensure t
  :hook ((org-mode TeX-mode) . mixed-pitch-mode)
  :general ('normal 'override "SPC t m" 'mixed-pitch-mode)
  :config (setq mixed-pitch-variable-pitch-cursor nil)) ;; keep filled cursor
