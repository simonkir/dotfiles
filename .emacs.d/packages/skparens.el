;;; skparens.el --- skparens                           -*- lexical-binding: t; -*-

;; Copyright (C) 2022  simonkir
;; Author: simonkir

;;; Code:



(setq skparens-pair-alist
      ;; general pairs
      '(("(" . ("( " . " )"))
        ("[" . ("[ " . " ]"))
        ("{" . ("{ " . " }"))
        ;; no spaces in between
        (")" . ("(" . ")"))
        ("]" . ("[" . "]"))
        ("}" . ("{" . "}"))
        ;; latex pairs
        ("r" . ("\\left( " . " \\right)"))
        ("s" . ("\\left[ " . " \\right]"))
        ("c" . ("\\left\\{ " . " \\right\\}"))
        ("a" . ("\\left| " . " \\right|"))
        ;; elisp pairs
        ("`" . ("`" . "'"))
        ;; quotes
        ("„" . ("„" . "“"))
        ("“" . ("“" . "”"))
        ("‚" . ("‚" . "‘"))
        ("‘" . ("‘" . "’"))))

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

(defun skparens-change (char replacement)
  "note: doesnt work well with nested parens"
  (interactive (list (skparens--read-delim) (skparens--read-delim)))
  (let ((old-opendelim (skparens--get-delim char nil))
        (old-closedelim (skparens--get-delim char 'closing))
        (new-opendelim (skparens--get-delim replacement nil))
        (new-closedelim (skparens--get-delim replacement 'closing)))
    (save-excursion
      ;; in case point if in front of old-opendelim,
      ;; search-backward wouldnt see it in this position
      (forward-char)
      (search-backward old-opendelim)
      (delete-char (length old-opendelim))
      (insert new-opendelim)
      ;; in case point if in front of old-closedelim,
      ;; search-forward wouldnt see it in this position
      (backward-char)
      (search-forward old-closedelim)
      (backward-char)
      (delete-char (length old-closedelim))
      (insert new-closedelim))))

(defun skparens-delete (char)
  "note: doesnt work well with nested parens"
  (interactive (list (skparens--read-delim)))
  (skparens-change char ""))

(defun skparens-surround-region (char)
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



(provide 'skparens)

;;; skparens.el ends here
