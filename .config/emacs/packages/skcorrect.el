;;; skcorrect.el --- skcorrect                         -*- lexical-binding: t; -*-

;; Author: simonkir

;;; Code:

; * helper functions
(defun skcorrect--correct-p ()
  "determine whether correction should be done"
  (cond
   ((derived-mode-p 'org-mode) (member (car (org-element-context)) '(headline paragraph)))
   ((derived-mode-p 'latex-mode) (not (texmathp)))
   (t nil)))

; * correction function
(defun skcorrect--dcaps-to-scaps ()
  "convert word in DOuble CApitals to Single Capitals while typing."
  (interactive)
  (when (skcorrect--correct-p)
    (save-excursion
      (let ((end (point)))
        (skip-syntax-backward "w")
        (when (let ((case-fold-search nil))
                (looking-at-p "\\b[[:upper:]]\\{2\\}[[:lower:]]\\b"))
          (capitalize-region (point) end))))))

(defun skcorrect--dspace-to-sspace ()
  "convert two or more spaces to single space while typing"
  (interactive)
  (when (skcorrect--correct-p)
    (save-excursion
      (left-char)
      (when (looking-at-p " +")
        (just-one-space)))))

; * minor-mode definition
(define-minor-mode skcorrect-mode nil
  :init-value nil
  :lighter (" skcorr")
  (when skcorrect-mode
    (add-hook 'post-self-insert-hook #'skcorrect--dcaps-to-scaps nil 'local)
    (add-hook 'post-self-insert-hook #'skcorrect--dspace-to-sspace nil 'local)
    (message "skcorrect-mode activated"))
  (unless skcorrect-mode
    (remove-hook 'post-self-insert-hook #'skcorrect--dcaps-to-scaps 'local)
    (remove-hook 'post-self-insert-hook #'skcorrect--dspace-to-sspace 'local)
    (message "skcorrect-mode deactivated")))

; * package
(provide 'skcorrect)

;;; skcorrect.el ends here
