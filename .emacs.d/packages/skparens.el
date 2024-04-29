;;; skparens.el --- skparens                           -*- lexical-binding: t; -*-

;; Author: simonkir

;;; Code:

; * variables
(setq skparens-pair-alist
      '(("(" . ("( " . " )"))
        ("[" . ("[ " . " ]"))
        ("{" . ("{ " . " }"))
        ("<" . ("< " . " >"))

        (")" . ("(" . ")"))
        ("]" . ("[" . "]"))
        ("}" . ("{" . "}"))
        (">" . ("<" . ">"))

        ;; latex pairs
        ("a" . ("\\left\\vert " . " \\right\\vert"))
        ("c" . ("\\left\\{ " . " \\right\\}"))
        ("n" . ("\\left\\Vert " . " \\right\\Vert"))
        ("r" . ("\\left( " . " \\right)"))
        ("s" . ("\\left[ " . " \\right]"))
        ("v" . ("\\left\\langle " . " \\right\\rangle"))

        ("A" . ("\\left\\vert" . "\\right\\vert"))
        ("C" . ("\\left\\{" . "\\right\\}"))
        ("N" . ("\\left\\vert " . " \\right\\vert"))
        ("R" . ("\\left(" . "\\right)"))
        ("S" . ("\\left[" . "\\right]"))
        ("V" . ("\\left\\langle" . "\\right\\rangle"))

        ;; lang-specific pairs
        ("`" . ("`" . "'"))       ;; elisp symbol quote
        ("\\" . ("/* " . " */"))  ;; c-like comment
        ("f" . ("f\"" . "\""))    ;; python f-string

        ;; quotes
        ("„" . ("„" . "“"))
        ("“" . ("“" . "”"))
        ("‚" . ("‚" . "‘"))
        ("‘" . ("‘" . "’"))))

(setq skparens--supported-nested-pairs '("(" ")" "[" "]" "{" "}"))

; * helper functions
(defun skparens--read-delim (&optional readstring)
  "read skparens-delimiter from the user"
  (if readstring
      (read-string)
    (char-to-string (read-char))))

(defun skparens--get-delim (char &optional closing)
  "return opening / closing delimiter associated with char"
  (let ((delims (assoc char skparens-pair-alist)))
    (if delims
        (progn
          (if closing
              (cddr delims)
            (cadr delims)))
      char)))

(defun skparens--get-bounds (char)
  "returns cons cell containing (starting) point of opening and closing occurence"
  (let ((opendelim (skparens--get-delim char nil))
        (closedelim (skparens--get-delim char 'closing))
        (point-beg -1)
        (point-end -1)
        (case-fold-search t))
    (save-excursion
      ;; in case point is in front of opendelim,
      ;; search-backward wouldnt see it in this position
      (forward-char)
      (search-backward opendelim)
      (setq point-beg (point))
      (if (member char skparens--supported-nested-pairs)
          (forward-sexp)
        ;; in case of unnested delims,
        ;; search-forward would mistake opendelim for closedelim otherwise
        (forward-char)
        (search-forward closedelim))
      (backward-char (length closedelim)) ;; go to beginning of search-hit
      (setq point-end (point)))
    (cons point-beg point-end)))

; * major functions
(defun skparens-mark-inner (char)
  (interactive (list (skparens--read-delim)))
  (let ((bounds (skparens--get-bounds char))
        (opendelim (skparens--get-delim char)))
    (goto-char (+ (length opendelim) (car bounds)))
    (push-mark (cdr bounds) t)
    (activate-mark)))

(defun skparens-mark-outer (char)
  (interactive (list (skparens--read-delim)))
  (let ((bounds (skparens--get-bounds char))
        (closedelim (skparens--get-delim char 'closing)))
    (goto-char (car bounds))
    (push-mark (+ (length closedelim) (cdr bounds)) t)
    (activate-mark)))

(defun skparens-change (char replacement)
  (interactive (list (skparens--read-delim) (skparens--read-delim)))
  (let ((old-opendelim (skparens--get-delim char nil))
        (old-closedelim (skparens--get-delim char 'closing))
        (new-opendelim (skparens--get-delim replacement nil))
        (new-closedelim (skparens--get-delim replacement 'closing))
        (bounds (skparens--get-bounds char)))
    (save-excursion
      ;; insert closing delim first, to avoid changing point of opening delim
      (goto-char (cdr bounds))
      (delete-char (length old-closedelim))
      (insert new-closedelim)
      (goto-char (car bounds))
      (delete-char (length old-opendelim))
      (insert new-opendelim))))

(defun skparens-delete (char)
  (interactive (list (skparens--read-delim)))
  (skparens-change char ""))

(defun skparens-insert (char)
  (interactive (list (skparens--read-delim)))
  (message char)
  (let ((beg (region-beginning))
        (end (region-end))
        (opendelim (skparens--get-delim char nil))
        (closedelim (skparens--get-delim char 'closing)))
    (save-excursion
      (goto-char end)
      (insert closedelim)
      (goto-char beg)
      (insert opendelim))))

; * package
(provide 'skparens)

;;; skparens.el ends here
