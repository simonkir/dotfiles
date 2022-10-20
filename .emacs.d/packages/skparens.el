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
        ("‚" . ("„" . "“"))
        ("‘" . ("‘" . "’"))))

(defun skparens--get-delim (char &optional closing)
  (let ((delims (assoc char skparens-pair-alist)))
    (if delims
        (progn
          (if closing
              (cddr delims)
            (cadr delims)))
      char)))

(defun skparens-surround-region-with (char)
  (interactive "k")
  (let* ((beg (region-beginning))
         (end (region-end))
         (opendelim (skparens--get-delim char nil))
         (closedelim (skparens--get-delim char 'closing-delim)))
    (save-excursion
      (goto-char end)
      (insert closedelim)
      (goto-char beg)
      (insert opendelim))))



(provide 'skparens)

;;; skparens.el ends here
