;;; -*- lexical-binding: t; -*-

; * helper functions
(defun sk:dcaps-to-scaps ()
  "convert word in DOuble CApitals to Single Capitals while typing."
  (interactive)
  (save-excursion
    (let ((end (point)))
      (skip-syntax-backward "w")
      (when (and (let ((case-fold-search nil))
                   (looking-at "\\b[[:upper:]]\\{2\\}[[:lower:]]"))
                 (not (sklatex-in-latex-p)))
        (capitalize-region (point) end)))))

(defun sk:dspace-to-sspace ()
  "convert two or more spaces to single space while typing"
  (interactive)
  (save-excursion
    (left-char)
    (and (looking-at " +")
         (eq (car (org-element-context)) 'paragraph)
         (just-one-space))))

; * minor-mode definition
(define-minor-mode sk:autocorrect-mode nil
  :init-value nil
  :lighter (" AC")
  (if sk:autocorrect-mode
      (progn (add-hook 'post-self-insert-hook #'sk:dcaps-to-scaps nil 'local)
             (add-hook 'post-self-insert-hook #'sk:dspace-to-sspace nil 'local)
             (message "sk:autocorrect-mode activated"))
    (remove-hook 'post-self-insert-hook #'sk:dcaps-to-scaps 'local)
    (remove-hook 'post-self-insert-hook #'sk:dspace-to-sspace 'local)
    (message "sk:autocorrect-mode deactivated")))

(add-hook 'org-mode-hook #'sk:autocorrect-mode)
(add-hook 'LaTeX-mode-hook #'sk:autocorrect-mode)

