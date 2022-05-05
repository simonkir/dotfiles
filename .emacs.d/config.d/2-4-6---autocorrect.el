;;; -*- lexical-binding: t; -*-



(defun sk:dcaps-to-scaps ()
  "Convert word in DOuble CApitals to Single Capitals while typing."
  (interactive)
  (and (= ?w (char-syntax (char-before)))
       (save-excursion
         (let ((end (point)))
           (and (if (called-interactively-p)
                    (skip-syntax-backward "w")
                  (= -3 (skip-syntax-backward "w")))
                (let (case-fold-search)
                  (looking-at "\\b[[:upper:]]\\{2\\}[[:lower:]]"))
                (not (texmathp))
                (capitalize-region (point) end))))))

(defun sk:dspace-to-sspace ()
  "Convert two  spaces to single space while typing."
  (interactive)
  (and (/= ?w (char-syntax (char-before)))
       (save-excursion
         (let ((end (point)))
           (and (if (called-interactively-p)
                    (skip-syntax-backward "-")
                  (= -2 (skip-syntax-backward "-")))
                (looking-at (rx (= 2 " ")))
                (not (texmathp))
                (just-one-space))))))

(define-minor-mode sk:autocorrect-mode nil
  :init-value nil
  :lighter (" AC")
  (if sk:autocorrect-mode
      (progn (add-hook 'post-self-insert-hook #'sk:dcaps-to-scaps nil 'local)
             (add-hook 'post-self-insert-hook #'sk:dspace-to-sspace nil 'local))
    (progn (remove-hook 'post-self-insert-hook #'sk:dcaps-to-scaps 'local)
           (remove-hook 'post-self-insert-hook #'sk:dspace-to-sspace 'local))))
