;;; -*- lexical-binding: t; -*-



(defun sk:dcaps-to-scaps ()
  "Convert word in DOuble CApitals to Single Capitals while typing."
  (interactive)
  (save-excursion
    (let ((end (point)))
      (skip-syntax-backward "w")
      (when (and (let ((case-fold-search nil))
                   (looking-at "\\b[[:upper:]]\\{2\\}[[:lower:]]"))
                 (not (sklatex-in-latex-p)))
        (capitalize-region (point) end)))))



(defun sk:dspace-to-sspace ()
  "Convert two or more spaces to single space while typing."
  (interactive)
  (save-excursion
    (left-char)
    (and (looking-at " +")
         (eq (car (org-element-context)) 'paragraph)
         (just-one-space))))



(defun sk:org-remove-empty-bullet ()
  "Remove empty org bullet after 'M-RET RET' in insert mode, or 'o RET' in normal mode"
  (interactive)
  (save-excursion
    (previous-line)
    (beginning-of-line)
    (when (and (looking-at "\\s-*\\(-\\|+\\|\\*\\|[[:digit:]]+\\.?)?\\)\\s-*$")
               (not (sklatex-in-latex-p)))
      (kill-line)
      (delete-horizontal-space))))



(define-minor-mode sk:autocorrect-mode nil
  :init-value nil
  :lighter (" AC")
  (if sk:autocorrect-mode
      (progn (add-hook 'post-self-insert-hook #'sk:dcaps-to-scaps nil 'local)
             (add-hook 'post-self-insert-hook #'sk:dspace-to-sspace nil 'local)
             (add-hook 'post-self-insert-hook #'sk:org-remove-empty-bullet nil 'local)
             (message "sk:autocorrect-mode activated"))
    (progn (remove-hook 'post-self-insert-hook #'sk:dcaps-to-scaps 'local)
           (remove-hook 'post-self-insert-hook #'sk:dspace-to-sspace 'local)
           (remove-hook 'post-self-insert-hook #'sk:org-remove-empty-bullet 'local)
           (message "sk:autocorrect-mode deactivated"))))
