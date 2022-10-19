;;; sklatex.el --- sklatex                           -*- lexical-binding: t; -*-

;; Copyright (C) 2022  simonkir
;; Author: simonkir

;;; Code:



(define-minor-mode sklatex-mode
  "skLaTeX mode"
  :lighter " skLaTeX"
  :keymap (make-sparse-keymap)
  (when sklatex-mode
    (message "sklatex-mode enabled")
    (add-hook 'post-self-insert-hook 'sklatex-try-newline-conversion nil 'local)
    (add-hook 'post-self-insert-hook 'sklatex-try-symbol-alignment nil 'local)
    (add-hook 'post-self-insert-hook 'sklatex-try-subscript-conversion nil 'local))
  (unless sklatex-mode
    (message "sklatex-mode disabled")
    (remove-hook 'post-self-insert-hook 'sklatex-try-newline-conversion)
    (remove-hook 'post-self-insert-hook 'sklatex-try-symbol-alignment)
    (remove-hook 'post-self-insert-hook 'sklatex-try-subscript-conversion)))

(defun sklatex-default-setup ()
  (interactive)
  (sklatex-activate-newline-keybinds)
  (sklatex-activate-alignment-keybinds-equality)
  (sklatex-activate-subscript-conversion))



; helper functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-in-latex-p ()
  "equivalent to `texmathp', but also works with latex-bocks in org-mode"
  (cond
   ((derived-mode-p 'latex-mode) (texmathp))
   ((derived-mode-p 'org-mode) (eq (car (org-element-context)) 'latex-environment))
   (t nil)))



; linebreak ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-activate-newline-keybinds ()
  (interactive)
  (setq TeX-newline-function 'electric-indent-just-newline)
  (setq sklatex--do-newline-conversion t)
  (message "sklatex: newline keybinds activated"))

(defun sklatex-deactivate-newline-keybinds ()
  (interactive)
  (setq TeX-newline-function 'newline)
  (setq sklatex--do-newline-conversion nil)
  (message "sklatex: newline keybinds deactivated"))

(defun sklatex--insert-newline ()
  (delete-horizontal-space)
  (delete-backward-char 1)
  (unless (eq ?\s (char-before (point)))
    (insert " "))
  (insert "\\\\\n  "))

(defun sklatex-try-newline-conversion ()
  (when (and sklatex--do-newline-conversion
             (sklatex-in-latex-p)
             (bolp)
             (save-excursion (previous-line) (beginning-of-line) (not (looking-at "\\\\begin")))
             (looking-at-p "$"))
    (sklatex--insert-newline)))



; equality ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq sklatex-aligned-symbols '("=" ">" "<" "\\\\leq" "\\\\geq" "\\\\rightleftharpoons" "\\\\longrightarrow" "\\\\longleftarrow"))

(defun sklatex--indent-for-symbol ()
  (let (symbol-length
        (point-eos (point)))
    (sklatex--goto-beginning-of-symbol)
    (setq symbol-length (- point-eos (point)))
    (let ((point-bol (save-excursion (beginning-of-line) (point)))
          (dummyvar nil))
      (let ((indentation-depth (- 4 (- (point) point-bol))))
        (dotimes (dummyvar indentation-depth)
          (insert " "))))
    (forward-char symbol-length)))

(defun sklatex--goto-beginning-of-symbol ()
  (re-search-backward "^\\| ")
  (when (looking-at " ")
    (forward-char)))

(defun sklatex--insert-alignment-around-symbol ()
  (save-excursion
    (sklatex--goto-beginning-of-symbol)
    (insert "&"))
  (insert "&"))

(defun sklatex-try-symbol-alignment ()
  (when (and sklatex--do-symbol-alignment
             (sklatex-in-latex-p))
    (let ((do-align nil))
      (save-excursion
        (sklatex--goto-beginning-of-symbol)
        (dolist (element sklatex-aligned-symbols)
          (when (looking-at-p element)
            (setq do-align t))))
      (when do-align
        (sklatex--indent-for-symbol)
        (sklatex--insert-alignment-around-symbol)))))

(defun sklatex-activate-alignment-keybinds-equality ()
  (interactive)
  (setq sklatex--do-symbol-alignment t)
  (message "sklatex: alignment keybinds activated"))

(defun sklatex-deactivate-alignment-keybinds-equality ()
  (interactive)
  (setq sklatex--do-symbol-alignment nil)
  (message "sklatex: alignment keybinds deactivated"))



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

(defun sklatex-try-subscript-conversion ()
  "determine which subscript conversion should be done and execute said conversion"
  (when (and sklatex--do-subscript-conversion
             (sklatex-in-latex-p))
    (let (conversion-method)
      (save-excursion
        (left-char 3)
        (cond
         ((looking-at "[[:alnum:]]}[[:alnum:]]") (setq conversion-method '(sklatex--input-delete-subscript)))
         ((looking-at "$?[^[:alnum:]][[:alpha:]][[:alnum:]]") (setq conversion-method '(sklatex--input-to-subscript)))))
      (eval conversion-method))))



(defun sklatex-activate-subscript-conversion ()
  (interactive)
  (setq sklatex--do-subscript-conversion t)
  (message "sklatex: automatic subscript activated"))

(defun sklatex-deactivate-subscript-conversion ()
  (interactive)
  (setq sklatex--do-subscript-conversion nil)
  (message "sklatex: automatic subscript deactivated"))



; removing sklatex-stuff  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex--delete-alignment-operators ()
  (unless (looking-at-p "&")
    (re-search-backward "&"))
  (delete-char 1)
  (re-search-backward "&")
  (delete-char 1))

(defun sklatex--delete-single-subscript ()
  "user-invoked command to delete unwanted subscript that was inserted automatically

not meant to be called from elisp. for this purpose, see sklatex--input-delete-subscript"
  (re-search-backward "_")
  (delete-char 2)
  (right-char)
  (delete-char 1))

(defun sklatex-remove-effect-at-point ()
  "depending on the previous character, remove effects added by sklatex"
  (interactive)
  (save-excursion
    (skip-syntax-backward "-")
    (left-char)
    (cond
     ((looking-at-p "&") (sklatex--delete-alignment-operators))
     ((looking-at-p "}") (sklatex--delete-single-subscript)))))

(general-def sklatex-mode-map
  "C-s" 'sklatex-remove-effect-at-point)



; user inferface ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-dispatch (key)
  "control which sklatex effects are active"
  (interactive "k")
  (cond
   ((string= key "k") (sklatex-default-setup))
   ((string= key "e") (sklatex-activate-alignment-keybinds-equality))
   ((string= key "E") (sklatex-deactivate-alignment-keybinds-equality))
   ((string= key "n") (sklatex-activate-newline-keybinds))
   ((string= key "N") (sklatex-deactivate-newline-keybinds))
   ((string= key "s") (sklatex-activate-subscript-conversion))
   ((string= key "S") (sklatex-deactivate-subscript-conversion))
   (t (message "%s: unsupported key" key))))



(provide 'sklatex)

;;; sklatex.el ends here
