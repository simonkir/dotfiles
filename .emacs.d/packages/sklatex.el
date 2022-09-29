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
        (sklatex-activate-alignment-keybinds-equality)
        (sklatex-activate-subscript-conversion))))



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
        (unless (eq ?\s (char-before (point)))
          (insert " "))
        (insert "\\\\\n  "))
    (cond ((derived-mode-p 'org-mode) (org-return))
          ((derived-mode-p 'latex-mode) (TeX-newline))
          (t (newline)))))

(defun sklatex-activate-newline-keybinds ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "RET" 'sklatex-insert-linebreak)
  (message "sklatex: newline keybinds activated"))

(defun sklatex-deactivate-newline-keybinds ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "RET" nil)
  (message "sklatex: newline keybinds deactivated"))




; equality ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex--insert-aligned-char (char trailing-alignment)
  (if (sklatex-in-latex-p)
      (progn
        (let (point-bol dummyvar)
          (save-excursion
            (beginning-of-line)
            (setq point-bol (point)))
          (dotimes (dummyvar (- 4 (- (point) point-bol)))
            (insert " ")))
        (insert (concat "&" char))
        (if trailing-alignment
            (insert "&")))
    (insert char)))

(defun sklatex-activate-alignment-keybinds-equality ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "|" '(lambda () (interactive) (sklatex--insert-aligned-char "|" nil))
    "=" '(lambda () (interactive) (sklatex--insert-aligned-char "=" t))
    "<" '(lambda () (interactive) (sklatex--insert-aligned-char "<" t))
    ">" '(lambda () (interactive) (sklatex--insert-aligned-char ">" t)))
  (message "sklatex: equality alignment keybinds activated"))

(defun sklatex-deactivate-alignment-keybinds-equality ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "|" nil
    "=" nil
    "<" nil
    ">" nil)
  (message "sklatex: equality alignment keybinds deactivated"))



; matricies ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-activate-alignment-keybinds-matrix ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" '(lambda () (interactive) (insert " & "))
    "S-SPC" '(lambda () (interactive) (insert " ")))
  (message "sklatex: matrix alignment keybinds activated"))

(defun sklatex-deactivate-alignment-keybinds-matrix ()
  (interactive)
  (general-def 'insert sklatex-mode-map
    "SPC" nil
    "S-SPC" nil)
  (message "sklatex: matrix alignment keybinds activated"))



; all ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-deactivate-alignment-keybinds-all ()
  (interactive)
  (sklatex-deactivate-alignment-keybinds-equality)
  (sklatex-deactivate-alignment-keybinds-matrix)
  (message "sklatex: all alignment keybinds deactivated"))



; escape binds ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def 'insert sklatex-mode-map
  "C-|" '(lambda () (interactive) (insert "|"))
  "C-=" '(lambda () (interactive) (insert "="))
  "C-<" '(lambda () (interactive) (insert "<"))
  "C->" '(lambda () (interactive) (insert ">")))



; subscript conversion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex--input-to-subscript ()
  "convert latex input to subscript"
  (save-excursion
    (left-char)
    (insert "_{")
    (right-char)
    (insert "}"))
  (right-char))

(defun sklatex--input-delete-subscript ()
  "remove subscript on latex input"
  (save-excursion
    (left-char 5)
    (delete-char 2)
    (right-char)
    (delete-char 1)))

(defun sklatex-delete-preceding-subscript ()
  "user-invoked command to delete unwanted subscript that was inserted automatically

not meant to be called from elisp. for this purpose, see sklatex--input-delete-subscript"
  (interactive)
  (when (sklatex-in-latex-p)
    (left-char 4)
    (delete-char 2)
    (right-char)
    (delete-char 1)))

(defun sklatex-try-subscript-conversion ()
  "determine which subscript conversion should be done and execute said conversion"
  (interactive)
  (when (sklatex-in-latex-p)
    (let (conversion-method)
      (save-excursion
        (left-char 3)
        (cond
         ((looking-at "[[:alnum:]]}[[:alnum:]]") (setq conversion-method '(sklatex--input-delete-subscript)))
         ((looking-at "\\s-[[:alpha:]][[:alnum:]]") (setq conversion-method '(sklatex--input-to-subscript)))))
      (eval conversion-method))))

(defun sklatex-activate-subscript-conversion ()
  (interactive)
  (add-hook 'post-self-insert-hook 'sklatex-try-subscript-conversion)
  (message "sklatex: automatic subscript activated"))

(defun sklatex-deactivate-subscript-conversion ()
  (interactive)
  (remove-hook 'post-self-insert-hook 'sklatex-try-subscript-conversion)
  (message "sklatex: automatic subscript deactivated"))

;; TODOs
;; - make it work with greek stuff
;; - solution for chemical equations



; user inferface ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-dispatch (key)
  (interactive "k")
  (cond ((string= key "e") (sklatex-activate-alignment-keybinds-equality))
        ((string= key "e") (sklatex-deactivate-alignment-keybinds-equality))
        ((string= key "m") (sklatex-activate-alignment-keybinds-matrix))
        ((string= key "M") (sklatex-deactivate-alignment-keybinds-matrix))
        ((string= key "K") (sklatex-deactivate-alignment-keybinds-all))
        ((string= key "n") (sklatex-activate-newline-keybinds))
        ((string= key "N") (sklatex-deactivate-newline-keybinds))
        ((string= key "s") (sklatex-activate-subscript-conversion))
        ((string= key "S") (sklatex-deactivate-subscript-conversion))
        (t (message "%s: unsupported key" key))))

(general-def 'insert sklatex-mode-map
  "C-s" 'sklatex-delete-preceding-subscript)



(provide 'sklatex)

;;; sklatex.el ends here
