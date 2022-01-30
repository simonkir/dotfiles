;;; -*- lexical-binding: t; -*-



; general settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org
  :defer t
  :config
  (add-hook    'org-mode-hook                'org-num-mode)
  (add-hook    'org-mode-hook                'org-indent-mode)
  (add-hook    'org-mode-hook                'org-display-inline-images)
  (add-hook    'org-mode-hook                'org-toggle-pretty-entities)
  (add-hook    'org-mode-hook                'flyspell-mode)
  (add-hook    'org-babel-after-execute-hook 'org-display-inline-images)

  (add-to-list 'org-latex-packages-alist     '("" "IEEEtrantools" t))

  ;; content
  (setq org-startup-folded     t)
  (setq org-hide-leading-stars t)
  (setq org-num-max-level      4)
  (setq org-src-window-setup 'current-window) ;; don't spread across two windows
  (setq org-image-actual-width nil)
  (setq org-list-demote-modify-bullet
        '(("+" . "-") ("-" . "+")
          ("1." . "-") ("1)" . "-")))
  (setq org-blank-before-new-entry '((heading . t) (plain-list-item . nil)))

  ;;(setq org-src-tab-acts-natively t)
  (setq org-confirm-babel-evaluate nil)

  ;; beautify fonts & font effects
  (setq org-hide-emphasis-markers          t)
  (setq org-fontify-whole-heading-line     t)
  (setq org-fontify-done-headline          t)
  (setq org-fontify-quote-and-verse-blocks t)

  ;; latex preview
  (setq org-preview-latex-scale-increment 0.2)
  (setq org-preview-latex-scale 1.5)
  (setq org-preview-latex-default-scale org-preview-latex-scale)
  (plist-put org-format-latex-options :scale org-preview-latex-default-scale)



  ;; disabled due to long loading time
  ;;(org-babel-do-load-languages
  ;; 'org-babel-load-languages
  ;; '((jupyter . t)))



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

	;; – toggle checkboxes
	;; – renumber ordered list
	;; – realign table
	;; – execute dynamic block
	;; – remove highlights
	;; – insert tags
    "RET" 'org-ctrl-c-ctrl-c

    "SPC e" 'org-edit-special)



  ; general mappings
  (general-def 'normal org-mode-map :prefix "SPC SPC"
    "-" 'org-ctrl-c-minus ;; separator line in table
    "i" 'org-ctrl-c-minus ;; toggle TODO item
    "b" 'org-ctrl-c-minus ;; cycle list bullet style

    "TAB"       'org-table-toggle-column-width
    "<backtab>" '(lambda () (interactive) (org-table-toggle-column-width '(4)))
    "c"         '(lambda () (interactive) (org-ctrl-c-ctrl-c             '(4)))

    "n" 'org-num-mode
    "h" 'org-toggle-heading
    "l" 'org-toggle-item
    "t" 'org-todo

    "f" 'org-table-eval-formula
    "F" '(lambda () (interactive) (org-table-eval-formula '(4)))

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

    "i" 'org-toggle-inline-images
    "I" 'org-display-inline-images)

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
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes '("scrlttr2" "\\documentclass[12pt,foldmarks=false,fromalign=right]{scrlttr2}"
                                    ("\\chapter{%s}" . "\\chapter*{%s}")
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))



; misc ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-superstar
  :ensure t
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("❃" "★" "✦" "•" "☆" "✧"))
  (setq org-superstar-item-bullet-alist '((42 . "•") (43 . "→") (45 . "–"))))




(use-package evil-org
  :ensure t
  :hook (org-mode . evil-org-mode))
