;;; sklatex.el --- sklatex                           -*- lexical-binding: t; -*-

;; Copyright (C) 2022  simonkir
;; Author: simonkir

;;; Code:



(define-minor-mode sklatex-mode
  "skLaTeX mode"
  :lighter " skLaTeX"
  :keymap (make-sparse-keymap)
  (if sklatex-mode
      (progn
        (sklatex-activate-newline-keybinds)
        (sklatex-activate-alignment-keybinds-equality))))




; helper functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-in-latex-p ()
  (cond
   ((derived-mode-p 'latex-mode) (texmathp))
   ((derived-mode-p 'org-mode) (eq (car (org-element-context)) 'latex-environment))
   (t nil)))



; linebreak ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-insert-linebreak ()
  (interactive)
  (if (sklatex-in-latex-p)
      (progn
        (unless (eq ?\s (char-after (- (point) 1)))
          (insert " "))
        (insert "\\\\\n  "))
    (cond ((derived-mode-p 'org-mode) (org-return))
          ((derived-mode-p 'latex-mode) (TeX-newline))
          (t (newline)))))

(defun sklatex-activate-newline-keybinds ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "RET" 'sklatex-insert-linebreak))

(defun sklatex-deactivate-newline-keybinds ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "RET" nil))




; equality ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex--current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at-p "[[:blank:]]*$")))

;; ; note: incompatible with prettify
;; (defun sklatex--indent-to-alignment-operator ()
;;   (let (prevbeg prevend curbeg curend)
;;     (if (sklatex--current-line-empty-p)
;;         (progn
;;           (save-excursion
;;             (setq curend (point))
;;             (beginning-of-line)
;;             (setq curbeg (point))
;;             (previous-line)
;;             (beginning-of-line)
;;             (setq prevbeg (point))
;;             (re-search-forward "&")
;;             (setq prevend (- (point) 1)))
;;           (dotimes (_ (- prevend prevbeg (- curend curbeg)))
;;             (insert " "))))))



; equality ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex--insert-aligned-char (char)
  (if (sklatex-in-latex-p)
      (progn
        (if (sklatex--current-line-empty-p)
            (insert "  "))
        (insert (concat "&" char "&")))
    (insert char)))

(defun sklatex-activate-alignment-keybinds-equality ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "|" '(lambda () (interactive) (sklatex--insert-aligned-char "|"))
    "=" '(lambda () (interactive) (sklatex--insert-aligned-char "="))
    "<" '(lambda () (interactive) (sklatex--insert-aligned-char "<"))
    ">" '(lambda () (interactive) (sklatex--insert-aligned-char ">"))))

(defun sklatex-deactivate-alignment-keybinds-equality ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "|" nil
    "=" nil
    "<" nil
    ">" nil))



; matricies ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-activate-alignment-keybinds-matrix ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" '(lambda () (interactive) (insert " & "))
    "S-SPC" '(lambda () (interactive) (insert " "))))

(defun sklatex-deactivate-alignment-keybinds-matrix ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" nil))



; all ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-deactivate-alignment-keybinds-all ()
  (interactive)
  (sklatex-deactivate-alignment-keybinds-equality)
  (sklatex-deactivate-alignment-keybinds-matrix))



; escape binds ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def 'insert sklatex-mode-map
  "C-|" '(lambda () (interactive) (insert "|"))
  "C-=" '(lambda () (interactive) (insert "="))
  "C-<" '(lambda () (interactive) (insert "<"))
  "C->" '(lambda () (interactive) (insert ">")))



; dispatch defun ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-dispatch (key)
  (interactive "k")
  (cond ((string= key "e") (sklatex-activate-alignment-keybinds-equality))
        ((string= key "e") (sklatex-deactivate-alignment-keybinds-equality))
        ((string= key "m") (sklatex-activate-alignment-keybinds-matrix))
        ((string= key "M") (sklatex-deactivate-alignment-keybinds-matrix))
        ((string= key "K") (sklatex-deactivate-alignment-keybinds-all))
        ((string= key "n") (sklatex-activate-newline-keybinds))
        ((string= key "N") (sklatex-deactivate-newline-keybinds))
        (t (message "key %s unsupported" key))))



(provide 'sklatex)

;;; sklatex.el ends here
