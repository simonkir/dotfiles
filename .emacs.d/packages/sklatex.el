;;; sklatex.el --- sklatex                           -*- lexical-binding: t; -*-

;; Copyright (C) 2022  simonkir
;; Author: simonkir

;;; Code:



(define-minor-mode sklatex-mode
  "skLaTeX mode"
  :lighter " skLaTeX"
  :keymap (make-sparse-keymap)
  (if sklatex-mode
      (sklatex-activate-alignment-keybinds-equality t)))



(defun sklatex-insert-linebreak ()
  (interactive)
  (if (texmathp)
      (progn
        (unless (eq ?\s (char-after (- (point) 1)))
          (insert " "))
        (insert "\\\\")
        (newline-and-indent))
    (newline-and-indent)))

(general-def 'insert sklatex-mode-map
  "RET" 'sklatex-insert-linebreak
  "<C-return>" '(lambda () (interactive) (insert "\n")))



(defun sklatex-activate-alignment-keybinds-equality (&optional inhibit-message)
  (interactive)
  (general-def 'insert sklatex-mode-map
    "|" '(lambda () (interactive) (insert "& |"))
    "=" '(lambda () (interactive) (insert "& = &"))
    "<" '(lambda () (interactive) (insert "& < &"))
    ">" '(lambda () (interactive) (insert "& > &")))
  (unless inhibit-message
    (message "Enabled TeX Alignment Keybinds for Equality Operators")))

(defun sklatex-deactivate-alignment-keybinds-equality (&optional inhibit-message)
  (interactive)
  (general-def 'insert sklatex-mode-map
    "|" '(lambda () (interactive) (insert "|"))
    "=" '(lambda () (interactive) (insert "="))
    "<" '(lambda () (interactive) (insert "<"))
    ">" '(lambda () (interactive) (insert ">")))
  (unless inhibit-message
    (message "Disabled TeX Alignment Keybinds for Equality Operators")))

(defun sklatex-activate-alignment-keybinds-matrix (&optional inhibit-message)
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" '(lambda () (interactive) (insert " & "))
    "S-SPC" '(lambda () (interactive) (insert " ")))
  (unless inhibit-message
    (message "Enabled TeX Alignment Keybinds for Matricies")))

(defun sklatex-deactivate-alignment-keybinds-matrix (&optional inhibit-message)
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" '(lambda () (interactive) (insert " "))
    "S-SPC" '(lambda () (interactive) (insert " ")))
  (unless inhibit-message
    (message "Disabled TeX Alignment Keybinds for Matricies")))

(defun sklatex-deactivate-alignment-keybinds-all (&optional inhibit-message)
  (interactive)
  (sklatex-deactivate-alignment-keybinds-equality)
  (sklatex-deactivate-alignment-keybinds-matrix)
  (unless inhibit-message
    (message "Disabled All TeX Alignment Keybinds")))



(general-def 'insert sklatex-mode-map
  "C-|" '(lambda () (interactive) (insert "|"))
  "C-=" '(lambda () (interactive) (insert "="))
  "C-<" '(lambda () (interactive) (insert "<"))
  "C->" '(lambda () (interactive) (insert ">")))



(defun sklatex-dispatch (key)
  (interactive "k")
  (cond
    ((string= key "e") (sklatex-activate-alignment-keybinds-equality))
    ((string= key "e") (sklatex-deactivate-alignment-keybinds-equality))
    ((string= key "m") (sklatex-activate-alignment-keybinds-matrix))
    ((string= key "M") (sklatex-deactivate-alignment-keybinds-matrix))
    ((string= key "K") (sklatex-deactivate-alignment-keybinds-all))
    (t (message "key %s unsupported" key))))



(provide 'sklatex)

;;; sklatex.el ends here
