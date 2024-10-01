;;; sklatex.el --- sklatex                           -*- lexical-binding: t; -*-

;; Author: simonkir

;;; Code:

; * variables
(setq sklatex-do-linebreak-conversion t)
(setq sklatex-do-symbol-alignment t)
(setq sklatex-do-subscript-conversion nil)

(setq sklatex-standard-math-symbol-width 2)
(setq sklatex-search-limit 30)

(setq sklatex-aligned-symbols
      '("=" "\\\\neq" "\\\\approx" "\\\\overset{!}{=}"
        ">" "<" "\\\\leq" "\\\\geq"
        ;; "\\\\le" "\\\\ge"
        ;; "\\\\rightleftharpoons" "\\\\longrightarrow"
        ))

; * minor mode definition
(define-minor-mode sklatex-mode
  "skLaTeX mode"
  :lighter " skLaTeX"
  :keymap (make-sparse-keymap)
  (when sklatex-mode
    (add-hook 'post-self-insert-hook #'sklatex-try-linebreak-conversion nil 'local)
    (add-hook 'post-self-insert-hook #'sklatex-try-symbol-alignment nil 'local)
    (add-hook 'post-self-insert-hook #'sklatex-try-subscript-conversion nil 'local)
    (message "sklatex-mode enabled"))
  (unless sklatex-mode
    (remove-hook 'post-self-insert-hook #'sklatex-try-linebreak-conversion 'local)
    (remove-hook 'post-self-insert-hook #'sklatex-try-symbol-alignment 'local)
    (remove-hook 'post-self-insert-hook #'sklatex-try-subscript-conversion 'local)
    (message "sklatex-mode disabled")))

; * helper functions
(defun sklatex-in-latex-p ()
  "slightly tweaked `texmathp'. ignores inline math, allows empty lines."
  (save-excursion
    (while (looking-at-p "^$")
      (backward-char))
    (and (texmathp)
         (not (member (car texmathp-why) '("$" "Org mode embedded math"))))))

(defun sklatex--backwards-search-limit ()
  (- (point) sklatex-search-limit))

; * main functionality
; ** linebreak
(defun sklatex--linebreak-insert-in-line-before ()
  (save-excursion
    (previous-line)
    (end-of-line)
    (unless (member (char-before (point)) '(?\s ?\n))
      (insert " "))
    (insert "\\\\")))

(defun sklatex--linebreak-delete ()
  (let ((linebreak-re "\\\\\\\\"))
    (unless (looking-at linebreak-re)
      (re-search-backward linebreak-re) (sklatex--backwards-search-limit))
    (delete-char 2)))

(defun sklatex-try-linebreak-conversion ()
  (when (and sklatex-do-linebreak-conversion
             (sklatex-in-latex-p))
    (unless (save-excursion
              (previous-line)
              (beginning-of-line)
              (looking-at ".*\\(\\\\end\\|\\\\begin\\|\\\\\\\\\\)"))
        (sklatex--linebreak-insert-in-line-before))))

; ** equality alignment
(defun sklatex--goto-beginning-of-symbol ()
  (skip-chars-backward "[:alnum:]^_{}+-\\\\" (sklatex--backwards-search-limit)))

(defun sklatex--indent-symbol ()
  (let (symbol-length
        (point-eos (point)))
    (sklatex--goto-beginning-of-symbol)
    (setq symbol-length (- point-eos (point)))
    (let ((point-bol (save-excursion (beginning-of-line) (point))))
      (let ((needed-indentation (- (+ LaTeX-indent-level sklatex-standard-math-symbol-width) (- (point) point-bol))))
        (dotimes (_ needed-indentation)
          (insert " "))))
    (forward-char symbol-length)))

(defun sklatex--insert-alignment-around-symbol ()
  (save-excursion
    (sklatex--goto-beginning-of-symbol)
    (insert "&"))
  (insert "&"))

(defun sklatex--delete-alignment-operators ()
  (dotimes (_ 2)
    (unless (looking-at-p "&")
      (re-search-backward "&" (sklatex--backwards-search-limit)))
    (delete-char 1)))

(defun sklatex-try-symbol-alignment ()
  (when (and sklatex-do-symbol-alignment
             (sklatex-in-latex-p))
    (let ((do-align nil))
      (save-excursion
        (sklatex--goto-beginning-of-symbol)
        (dolist (element sklatex-aligned-symbols)
          (when (looking-at-p element)
            (setq do-align t))))
      (when do-align
        (sklatex--indent-symbol)
        (sklatex--insert-alignment-around-symbol)))))

; ** subscript conversion
(defun sklatex--input-to-subscript ()
  "wrap previous char as subscript"
  (left-char)
  (insert "_{")
  (right-char)
  (insert "}")
  (left-char))

(defun sklatex--delete-supersubscript ()
  "user-invoked command to delete unwanted subscript that was inserted automatically"
  (let ((supersubscript-re "[_^]{?.+}?"))
    (unless (looking-at-p supersubscript-re)
      (re-search-backward supersubscript-re (sklatex--backwards-search-limit)))
    ;; delete super-/subscript operator
    (delete-char 1)
    ;; delete surrounding braces
    (when (looking-at-p "{")
      (delete-char 1)
      (re-search-forward "}")
      (delete-backward-char 1))))

(defun sklatex-try-subscript-conversion ()
  "determine which subscript conversion should be done and execute said conversion"
  (when (and sklatex-do-subscript-conversion
             (sklatex-in-latex-p))
    (let* ((end (point))
           (beg (save-excursion (skip-chars-backward "[:alnum:]^_{}+-\\\\" (sklatex--backwards-search-limit)) (point)))
           (symbol (buffer-substring beg end)))
      (cond
       ((and (not (string-match "[_^]" symbol))
             (>= (length symbol) sklatex-standard-math-symbol-width))
        ;; (eq 0 (string-match "[[:alpha:]\\][[:alnum:]]*" symbol)))
        (sklatex--input-to-subscript))))))

; * keybinds
(defun sklatex-remove-effect-at-point ()
  "depending on the previous character, remove effects added by sklatex"
  (interactive)
  (save-excursion
    (re-search-backward "[&_^]\\|\\\\\\\\" (sklatex--backwards-search-limit))
    (cond
     ((looking-at-p "&") (sklatex--delete-alignment-operators))
     ((looking-at-p "[_^]") (sklatex--delete-supersubscript))
     ((looking-at-p "\\\\\\\\") (sklatex--linebreak-delete)))))

(general-def sklatex-mode-map
  "C-s" 'sklatex-remove-effect-at-point)

; * package
(provide 'sklatex)

;;; sklatex.el ends here
