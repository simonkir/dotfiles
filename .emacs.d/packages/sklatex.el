;;; sklatex.el --- sklatex                           -*- lexical-binding: t; -*-

;; Author: simonkir



;;; Code:

; definition of variables ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq sklatex--do-newline-conversion nil)
(setq sklatex--do-symbol-alignment nil)
(setq sklatex--do-subscript-conversion nil)
(setq sklatex--do-chemical-formula-conversion nil)



; minor mode / defaults ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-minor-mode sklatex-mode
  "skLaTeX mode"
  :lighter " skLaTeX"
  :keymap (make-sparse-keymap)
  (when sklatex-mode
    (message "sklatex-mode enabled")
    (add-hook 'post-self-insert-hook #'sklatex-try-newline-conversion nil 'local)
    (add-hook 'post-self-insert-hook #'sklatex-try-symbol-alignment nil 'local)
    (add-hook 'post-self-insert-hook #'sklatex-try-subscript-conversion nil 'local))
  (unless sklatex-mode
    (message "sklatex-mode disabled")
    (remove-hook 'post-self-insert-hook #'sklatex-try-newline-conversion 'local)
    (remove-hook 'post-self-insert-hook #'sklatex-try-symbol-alignment 'local)
    (remove-hook 'post-self-insert-hook #'sklatex-try-subscript-conversion 'local)))

(defun sklatex-default-setup ()
  (interactive)
  (sklatex-activate-newline-keybinds)
  (sklatex-activate-alignment-keybinds-equality)
  (message "sklatex: default keybinds activated (newline, alignment)"))



; helper functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-in-latex-p ()
  "equivalent to `texmathp', but also works with latex-bocks in org-mode"
  (cond
   ((derived-mode-p 'latex-mode) (texmathp))
   ((derived-mode-p 'org-mode) (eq (car (org-element-context)) 'latex-environment))
   (t nil)))

(defun sklatex--string-nth (pos string)
  (substring string pos (1+ pos)))



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

(defun sklatex--insert-newline-with-\\ ()
  (delete-horizontal-space)
  (delete-backward-char 1)
  (unless (eq ?\s (char-before (point)))
    (insert " "))
  (insert "\\\\\n  "))

(defun sklatex--insert-newline-without-\\ ()
  (delete-horizontal-space)
  (delete-backward-char 1)
  (unless (eq ?\s (char-before (point)))
    (insert " "))
  (insert "\n  "))

(defun sklatex-try-newline-conversion ()
  (when (and sklatex--do-newline-conversion
             (sklatex-in-latex-p)
             (bolp)
             (looking-at-p "$"))
    (if (save-excursion (previous-line) (beginning-of-line) (not (looking-at "\\\\begin\\|.*\\\\\\\\")))
        (sklatex--insert-newline-with-\\)
      (sklatex--insert-newline-without-\\))))



; equality ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq sklatex-aligned-symbols '("=" ">" "<" "\\\\neq" "\\\\approx" "\\\\leq" "\\\\geq" "\\\\rightleftharpoons" "\\\\longrightarrow" "\\\\overset{!}{=}"))

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
  ;;(re-search-backward "^\\| " (- (point) 30))
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

(defun sklatex--delete-alignment-operators ()
  (unless (looking-at-p "&")
    (re-search-backward "&" (- (point) 30)))
  (delete-char 1)
  (re-search-backward "&" (- (point) 30))
  (delete-char 1))

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
  "convert previous char to subscript"
  (save-excursion
    (left-char)
    (insert "_{")
    (right-char)
    (insert "}"))
  (right-char))

(defun sklatex--input-to-charge ()
  "convert previous char to charge (when using chemistry mode)"
  (save-excursion
    (left-char 3)
    (if (not (looking-at-p "[-+]"))
        ;; insert superscript
        (progn
          (right-char 2)
          (insert "^{")
          (right-char)
          (insert "}"))

      ;; pull charge into superscript
      (right-char 1)
      (delete-char 1)
      (right-char 1)
      (insert "}")

      ;; calculate and insert correct charge
      ;; works by analysing and replacing the char string inside the superscript
      (let* ((beg (progn (search-backward "{" (- (point) 5)) (1+ (point))))
             (end (progn (search-forward "}" (+ (point) 5)) (1- (point))))
             (charge-chars (buffer-substring-no-properties beg end))
             (charge-chars (concat (if (= (length charge-chars) 2) "1" "") charge-chars)) ;; ensures format [[:digit:]][-+][-+]
             (charge-sign-1 (if (string= (sklatex--string-nth 1 charge-chars) "-") -1 1))
             (charge-1 (* charge-sign-1 (string-to-number (sklatex--string-nth 0 charge-chars))))
             (charge-2 (if (string= (sklatex--string-nth 2 charge-chars) "-") -1 1))
             (charge-0 (+ charge-1 charge-2)))
        (if (eq charge-0 0)
            ;; remove superscript
            (delete-region (- beg 2) (1+ end))
          ;; replace superscript with correct charge
          (delete-region beg end)
          (left-char)
          (unless (= (abs charge-0) 1)
            (insert (number-to-string (abs charge-0))))
          (if (< charge-0 0)
              (insert "-")
            (insert "+"))))))
  (search-forward "}" (+ (point) 3)))

(defun sklatex--delete-supersubscript ()
  "user-invoked command to delete unwanted subscript that was inserted automatically

not meant to be called from elisp. for this purpose, see sklatex--input-delete-subscript"
  (re-search-backward "[\\^_]" (- (point) 30))
  (delete-char 2)
  (search-forward "}")
  (delete-backward-char 1))

(setq sklatex--chemical-formula-rx "\\([[:upper:]][[:lower:]]?\\(_{[[:digit:]]+}\\)?\\)+\\(\\^{[[:digit:]+-]+}\\)?")
(setq sklatex--mathematical-quantity-rx "[[:alnum:]]*_{[[:alnum:]]}[[:alnum:]]")

(defun sklatex-try-subscript-conversion ()
  "determine which subscript conversion should be done and execute said conversion"
  (let* ((conversion-method)
         (end (point))
         (beg (save-excursion (skip-chars-backward "[:alnum:]^_{}+-\\\\") (point)))
         (symbol (buffer-substring beg end)))
    (cond
     ;; chemical subscript (index numbers)
     ((and sklatex--do-chemical-formula-conversion
           (string-match (concat sklatex--chemical-formula-rx "[[:digit:]]") symbol))
      (sklatex--input-to-subscript))
     ;; chemical superscript (charges)
     ((and sklatex--do-chemical-formula-conversion
           (string-match (concat sklatex--chemical-formula-rx "[-+]") symbol))
      (sklatex--input-to-charge))
     ;; delete mathematical subscript (when writing words)
     ((and sklatex--do-subscript-conversion (sklatex-in-latex-p)
           (string-match sklatex--mathematical-quantity-rx symbol))
      (sklatex--delete-supersubscript))
     ;; mathematical subscript (e. g. when using indexed quantities)
     ((and sklatex--do-subscript-conversion (sklatex-in-latex-p)
           (string-match "[[:alpha:]][[:alnum:]]" symbol))
      (sklatex--input-to-subscript)))))



(defun sklatex-activate-subscript-conversion ()
  (interactive)
  (sklatex-deactivate-chemical-formula-conversion)
  (setq sklatex--do-subscript-conversion t)
  (message "sklatex: automatic subscript activated"))

(defun sklatex-deactivate-subscript-conversion ()
  (interactive)
  (setq sklatex--do-subscript-conversion nil)
  (message "sklatex: automatic subscript deactivated"))

(defun sklatex-activate-chemical-formula-conversion ()
  (interactive)
  (sklatex-deactivate-subscript-conversion)
  (setq sklatex--do-chemical-formula-conversion t)
  (message "sklatex: chemical formula conversion activated"))

(defun sklatex-deactivate-chemical-formula-conversion ()
  (interactive)
  (setq sklatex--do-chemical-formula-conversion nil)
  (message "sklatex: chemical formula conversion deactivated"))



; user inferface ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sklatex-remove-effect-at-point ()
  "depending on the previous character, remove effects added by sklatex"
  (interactive)
  (save-excursion
    (re-search-backward "[&}]" (- (point) 30))
    (cond
     ((looking-at-p "&") (sklatex--delete-alignment-operators))
     ((looking-at-p "}") (sklatex--delete-supersubscript)))))

(general-def sklatex-mode-map
  "C-s" 'sklatex-remove-effect-at-point)

(defun sklatex-dispatch (key)
  "control which sklatex effects are active"
  (interactive "ksklatex-dispatch: (k) default setup – (e)quality keys – (n)ewline keys – (s)ubscript conversion – (c)hemical sub-/superscript conversion")
  (cond
   ((string= key "k") (sklatex-default-setup))
   ((string= key "e") (sklatex-activate-alignment-keybinds-equality))
   ((string= key "E") (sklatex-deactivate-alignment-keybinds-equality))
   ((string= key "n") (sklatex-activate-newline-keybinds))
   ((string= key "N") (sklatex-deactivate-newline-keybinds))
   ((string= key "s") (sklatex-activate-subscript-conversion))
   ((string= key "S") (sklatex-deactivate-subscript-conversion))
   ((string= key "c") (sklatex-activate-chemical-formula-conversion))
   ((string= key "C") (sklatex-deactivate-chemical-formula-conversion))
   (t (message "%s: unsupported key" key))))



(provide 'sklatex)

;;; sklatex.el ends here
