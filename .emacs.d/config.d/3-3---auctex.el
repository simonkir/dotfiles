;;; -*- lexical-binding: t; -*-



(use-package tex
  :defer t
  :ensure auctex

  :init
  ;; in init bc. org-mode needs it, too
  (setq texmathp-tex-commands '())
  (add-to-list 'texmathp-tex-commands (quote ("IEEEeqnarray" env-on
                                              "IEEEeqnarray*" env-on)))

  :custom
  (TeX-auto-save  t)
  (TeX-parse-self t)
  (TeX-error-overview-open-after-TeX-run t)

  (LaTeX-math-abbrev-prefix "#")

  (TeX-view-program-selection '((output-pdf "PDF Tools")))
  (TeX-source-correlate-mode  t)

  (preview-scale-function      1.5)
  (preview-auto-cache-preamble t)

  :config
  (add-to-list 'TeX-source-correlate-method '(pdf . synctex))
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'prettify-symbols-mode)

  (general-def 'normal TeX-mode-map :prefix "SPC SPC"
    "s"   'LaTeX-section            ;; insert section
    "e"   'LaTeX-environment        ;; insert environment
    "TAB" 'LaTeX-fill-environment   ;; auto-indent
    "l"   'TeX-command-master
    "L"   'TeX-command-run-all)

  (general-def 'normal TeX-mode-map :prefix "SPC p"
    "p" 'preview-at-point
    "P" 'preview-clearout-at-point
    "b" 'preview-buffer
    "B" 'preview-clearout-buffer))
