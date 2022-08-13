;;; -*- lexical-binding: t; -*-



; font settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(set-face-attribute 'default nil :family "Monospace" :height 100)
(set-face-attribute 'variable-pitch nil :family "Noto Serif" :height 100)



; font switching ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq sk:fonts-fixed-pitch '("Monospace" "Roboto Mono" "Source Code Pro"))
(setq sk:fonts-variable-pitch '("Noto Serif" "C059" "Georgia" "Ubuntu" "Noto Sans"))

(defun sk:set-face-fixed ()
  (interactive)
  (let* ((new-face (completing-read "new fixed-pitch face: " sk:fonts-fixed-pitch nil nil))
         (height (if (string= new-face "Inconsolata")
                     (setq height 110)
                   (setq height 100))))
    (set-face-attribute 'default nil :family new-face :height height)))

(defun sk:set-face-variable ()
  (interactive)
  (let ((new-face (completing-read "new variable-pitch face: " sk:fonts-variable-pitch nil nil))
        (height 100))
    (set-face-attribute 'variable-pitch nil :family new-face :height height))
  (if (eq mixed-pitch-mode t)
      (progn
        (mixed-pitch-mode 'toggle)
        (mixed-pitch-mode 'toggle))))

(general-def '(normal visual) 'override :prefix "SPC d"
  "f" 'sk:set-face-fixed
  "v" 'sk:set-face-variable)



; mixed-pitch mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package mixed-pitch
  :hook ((org-mode TeX-mode text-mode) . mixed-pitch-mode)
  :general ('normal 'override "SPC d m" 'mixed-pitch-mode)
  :config
  (setq mixed-pitch-variable-pitch-cursor nil)
  (setq mixed-pitch-set-height t)) ;; keep filled cursor
