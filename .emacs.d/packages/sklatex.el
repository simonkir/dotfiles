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



; linebreak ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-insert-linebreak ()
  (interactive)
  (if (texmathp)
      (progn
        (unless (eq ?\s (char-after (- (point) 1)))
          (insert " "))
        (insert "\\\\\n  "))
    (self-insert-command)))

(general-def 'insert sklatex-mode-map
  "RET" 'sklatex-insert-linebreak
  "<C-return>" '(lambda () (interactive) (insert "\n")))



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
  (if (sklatex--current-line-empty-p)
      (insert "  "))
  (insert (concat "&" char "&")))

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
    "|" 'self-insert-command
    "=" 'self-insert-command
    "<" 'self-insert-command
    ">" 'self-insert-command))



; matricies ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-activate-alignment-keybinds-matrix ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" '(lambda () (interactive) (insert " & "))
    "S-SPC" '(lambda () (interactive) (insert " "))))

(defun sklatex-deactivate-alignment-keybinds-matrix ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" 'self-insert-command))



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
  (cond
    ((string= key "e") (sklatex-activate-alignment-keybinds-equality))
    ((string= key "e") (sklatex-deactivate-alignment-keybinds-equality))
    ((string= key "m") (sklatex-activate-alignment-keybinds-matrix))
    ((string= key "M") (sklatex-deactivate-alignment-keybinds-matrix))
    ((string= key "K") (sklatex-deactivate-alignment-keybinds-all))
    (t (message "key %s unsupported" key))))



(provide 'sklatex)

;;; sklatex.el ends here
