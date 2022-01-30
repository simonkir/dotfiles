;;; -*- lexical-binding: t; -*-



; parenthesis ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package electric
  :demand t
  :config
  (electric-pair-mode t)

  (add-to-list 'electric-pair-pairs '(8218 . 8216)) ;; ‚‘
  (add-to-list 'electric-pair-pairs '(8222 . 8220)) ;; „“

  (defun sk:electric-add-latex-parenthesis ()
    (interactive)
    (make-local-variable 'electric-pair-pairs)
    (add-to-list 'electric-pair-pairs '(36 . 36))) ;; $|$

  (add-hook 'org-mode-hook 'sk:electric-add-latex-parenthesis)
  (add-hook 'TeX-mode-hook 'sk:electric-add-latex-parenthesis))



; autocompletion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :ensure t
  :hook
  (after-init . company-tng-mode)
  (after-init . global-company-mode)

  :config
  (setq company-idle-delay 0.3)
  (setq company-minimum-prefix-length 2)
  (general-def company-active-map "C-w" 'evil-delete-backward-word))

(use-package company-math
  :ensure t
  :after company
  :config (add-to-list 'company-backends 'company-math-symbols-unicode))
