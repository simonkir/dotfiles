;;; -*- lexical-binding: t; -*-



; general settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org
  :defer t

  :custom
  (org-src-window-setup 'current-window) ;; don't spread across two windows

  ;; section numbering & indentation
  (org-hide-leading-stars t)
  (org-num-max-level      4)

  ;; beautify fonts & font effects
  (org-hide-emphasis-markers          t)
  (org-fontify-whole-heading-line     t)
  (org-fontify-done-headline          t)
  (org-fontify-quote-and-verse-blocks t)

  (org-list-demote-modify-bullet
        '(("+" . "-") ("-" . "+")
          ("1." . "-") ("1)" . "-")))

  ;;(setq org-src-tab-acts-natively t)
  (org-confirm-babel-evaluate nil)

  ;; latex preview options
  (org-preview-latex-scale-increment 0.2)
  (org-preview-latex-scale 1.5)
  (org-preview-latex-default-scale org-preview-latex-scale)

  :config
  (add-hook    'org-mode-hook                'org-num-mode)
  (add-hook    'org-mode-hook                'org-indent-mode)
  (add-hook    'org-babel-after-execute-hook 'org-display-inline-images)

  (add-to-list 'org-latex-packages-alist     '("" "IEEEtrantools" t))



  (org-babel-do-load-languages
   'org-babel-load-languages
   (append org-babel-load-languages
           '((jupyter . t))))



  (plist-put org-format-latex-options :scale org-preview-latex-default-scale)

  (defun org-preview-latex-scale--aftermath ()
    (plist-put org-format-latex-options :scale org-preview-latex-scale)
    (message "%s" (concat "latex preview scale set to " (number-to-string org-preview-latex-scale))))

  (defun org-preview-latex-scale-increase ()
    (interactive)
    (setq org-preview-latex-scale (+ org-preview-latex-scale org-preview-latex-scale-increment))
    (org-preview-latex-scale--aftermath))

  (defun org-preview-latex-scale-decrease ()
    (interactive)
    (setq org-preview-latex-scale (- org-preview-latex-scale org-preview-latex-scale-increment))
    (org-preview-latex-scale--aftermath))

  (defun org-preview-latex-scale-set (new-scale)
    (interactive "nnew preview scale: ")
    (setq org-preview-latex-scale new-scale)
    (org-preview-latex-scale--aftermath))

  (defun org-preview-latex-scale-reset ()
    (interactive)
    (setq org-preview-latex-scale org-preview-latex-default-scale)
    (org-preview-latex-scale--aftermath))



  ; editing source code blocks
  (general-def 'normal org-mode-map
    "RET" 'org-ctrl-c-ctrl-c
    "SPC e" 'org-edit-special)


  ; general mappings
  (general-def 'normal org-mode-map :prefix "SPC SPC"
    "o" 'org-ctrl-c-minus
    "-" 'org-ctrl-c-minus
    "i" 'org-ctrl-c-minus
    "b" 'org-ctrl-c-minus

    "TAB"       'org-table-toggle-column-width
    "<backtab>" '(lambda () (interactive) (org-table-toggle-column-width '(4)))
    "c"         '(lambda () (interactive) (org-ctrl-c-ctrl-c             '(4)))

    "n" 'org-num-mode
    "h" 'org-toggle-heading
    "t" 'org-todo

    "e" 'org-babel-execute-buffer)



  ; preview mappings
  (general-def 'normal org-mode-map :prefix "SPC p"
    "p" 'org-latex-preview
    "P" '(lambda () (interactive) (org-latex-preview '(4)))
    "b" '(lambda () (interactive) (org-latex-preview '(16)))
    "B" '(lambda () (interactive) (org-latex-preview '(64)))
    "+" 'org-preview-latex-scale-increase
    "-" 'org-preview-latex-scale-decrease
    "0" 'org-preview-latex-scale-reset
    "s" 'org-preview-latex-scale-set

    "I" 'org-toggle-inline-images
    "i" 'org-display-inline-images)

  (general-def 'normal
    "SPC e" 'org-edit-src-exit))



; export settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ox
  :after org

  :general ('normal org-mode-map :prefix "SPC SPC"
                    "X" 'org-export-dispatch
                    "x" '(lambda () (interactive) (org-export-dispatch '(4)))))



(use-package ox-latex
  :after ox

  :config
  (add-to-list 'org-latex-classes '("report-nopart" "\\documentclass[11pt]{report}"
                                    ("\\chapter{%s}" . "\\chapter*{%s}")
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))



; misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-superstar
  :after org
  :ensure t
  :custom
  (org-superstar-headline-bullets-list '("❃" "★" "✦" "•" "☆" "✧"))
  (org-superstar-item-bullet-alist '((42 . "•") (43 . "→") (45 . "–")))

  :hook
  (org-mode . org-superstar-mode))



(use-package evil-org
  :after org
  :ensure t
  :hook
  (org-mode . evil-org-mode))
