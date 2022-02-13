;;; -*- lexical-binding: t; -*-



(use-package tex
  :ensure auctex
  :defer t
  :init
  ;; in init because org-mode needs it too
  (setq texmathp-tex-commands '())
  (add-to-list 'texmathp-tex-commands (quote ("IEEEeqnarray" env-on)))
  (add-to-list 'texmathp-tex-commands (quote ("IEEEeqnarray\*" env-on)))



  :config
  (setq TeX-auto-save  t)
  (setq TeX-parse-self t)
  (setq TeX-error-overview-open-after-TeX-run nil)



  ; output / viewing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (setq TeX-source-correlate-mode  t)
  (add-to-list 'TeX-source-correlate-method '(pdf . synctex))



  ; math settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode
  ;;(setq LaTeX-math-abbrev-prefix "#")
  (setq TeX-insert-braces nil)

  (setq preview-scale-function      1.5)
  (setq preview-auto-cache-preamble t)



  ; mappings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  (general-def 'insert TeX-mode-map
    "<C-return>" '(lambda () (interactive) (insert " \\\\\n  ")))

  (general-def 'normal TeX-mode-map :prefix "SPC SPC"
    "s"   'LaTeX-section            ;; insert section
    "e"   'LaTeX-environment        ;; insert environment
    "TAB" 'LaTeX-fill-environment)  ;; auto-indent

  (general-def 'normal TeX-mode-map :prefix "SPC SPC l"
    "l" 'preview-at-point
    "L" 'preview-clearout-at-point
    "b" 'preview-buffer
    "B" 'preview-clearout-buffer)



  ; special keybinds ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun sk:activate-tex-alignment-keybinds-equality ()
    (interactive)
    (general-def 'insert TeX-mode-map
      "C-<" '(lambda () (interactive) (insert "& \\leq &"))
      "C->" '(lambda () (interactive) (insert "& \\geq &"))
      "=" '(lambda () (interactive) (insert "& = &"))
      "<" '(lambda () (interactive) (insert "& < &"))
      ">" '(lambda () (interactive) (insert "& > &")))
    (message "Enabled TeX Alignment Keybinds for Equality Operators"))

  (defun sk:deactivate-tex-alignment-keybinds-equality ()
    (interactive)
    (general-def 'insert TeX-mode-map
      "C-<" '(lambda () (interactive) (insert "\\leq"))
      "C->" '(lambda () (interactive) (insert "\\geq"))
      "=" '(lambda () (interactive) (insert "="))
      "<" '(lambda () (interactive) (insert "<"))
      ">" '(lambda () (interactive) (insert ">")))
    (message "Disabled TeX Alignment Keybinds for Equality Operators"))

  (defun sk:activate-tex-alignment-keybinds-matrix ()
    (interactive)
    (general-def 'insert TeX-mode-map
      "SPC" '(lambda () (interactive) (insert " & "))
      "C-SPC" '(lambda () (interactive) (insert " ")))
    (message "Enabled TeX Alignment Keybinds for Matricies"))

  (defun sk:deactivate-tex-alignment-keybinds-matrix ()
    (interactive)
    (general-def 'insert TeX-mode-map
      "SPC" '(lambda () (interactive) (insert " "))
      "C-SPC" '(lambda () (interactive) (insert " ")))
    (message "Disabled TeX Alignment Keybinds for Matricies"))
  
  (defun sk:deactivate-tex-alignment-keybinds-all ()
    (interactive)
    (sk:deactivate-tex-alignment-keybinds-equality)
    (sk:deactivate-tex-alignment-keybinds-matrix)
    (message "Disabled All TeX Alignment Keybinds"))

  (sk:activate-tex-alignment-keybinds-equality)

  (general-def 'normal TeX-mode-map :prefix "SPC SPC k"
    "e" 'sk:activate-tex-alignment-keybinds-equality
    "E" 'sk:deactivate-tex-alignment-keybinds-equality
    "m" 'sk:activate-tex-alignment-keybinds-matrix
    "M" 'sk:deactivate-tex-alignment-keybinds-matrix
    "K" 'sk:deactivate-tex-alignment-keybinds-all))



(use-package cdlatex
  :ensure t
  :defer t
  :hook
  (LaTeX-mode . cdlatex-mode)
  (org-mode . org-cdlatex-mode)

  :config
  (setq cdlatex-math-symbol-prefix ?#)
  (setq cdlatex-simplify-sub-super-scripts nil)
  (setq cdlatex-paired-parens "$([{")
  (setq cdlatex-math-symbol-alist '((?F ("\\Phi"))))
  (general-def (cdlatex-mode-map org-mode-map)
    "#" 'cdlatex-math-symbol))
    ;;"TAB" nil
    ;;"<tab>" nil))



(use-package evil-tex
  :ensure t
  :defer t
  :hook (LaTeX-mode . evil-tex-mode))
