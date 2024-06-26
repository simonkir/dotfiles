;;; skcorrect.el --- skcorrect                         -*- lexical-binding: t; -*-

;; Author: simonkir

;;; Code:

; * helper functions
(defun skcorrect--dcaps-to-scaps ()
  "convert word in DOuble CApitals to Single Capitals while typing."
  (interactive)
  (save-excursion
    (let ((end (point)))
      (skip-syntax-backward "w")
      (when (and (let ((case-fold-search nil))
                   (looking-at "\\b[[:upper:]]\\{2\\}[[:lower:]]"))
                 (not (sklatex-in-latex-p)))
        (capitalize-region (point) end)))))

(defun skcorrect--dspace-to-sspace ()
  "convert two or more spaces to single space while typing"
  (interactive)
  (save-excursion
    (left-char)
    (and (looking-at " +")
         (eq (car (org-element-context)) 'paragraph)
         (just-one-space))))

; * minor-mode definition
(define-minor-mode skcorrect-mode nil
  :init-value nil
  :lighter (" skcor")
  (if skcorrect-mode
      (progn (add-hook 'post-self-insert-hook #'skcorrect--dcaps-to-scaps nil 'local)
             (add-hook 'post-self-insert-hook #'skcorrect--dspace-to-sspace nil 'local)
             (message "skcorrect-mode activated"))
    (remove-hook 'post-self-insert-hook #'skcorrect--dcaps-to-scaps 'local)
    (remove-hook 'post-self-insert-hook #'skcorrect--dspace-to-sspace 'local)
    (message "skcorrect-mode deactivated")))

; * package
(provide 'skcorrect)

;;; skcorrect.el ends here
