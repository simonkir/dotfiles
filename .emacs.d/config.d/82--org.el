;;; -*- lexical-binding: t; -*-

; * org
(use-package org
  :general (general-def-leader
             "r n" #'(lambda () (interactive) (org-agenda nil "n"))
             "r N" 'org-agenda
             "r c" '(lambda () (interactive) (org-capture nil "c"))
             "r C" 'org-capture)

  :config

; ** visuals
  (setq org-num-max-level 3)
  (setq org-return-follows-link t)
  (setq org-image-actual-width nil)

  (setq org-startup-folded t)
  (setq org-hide-leading-stars t)
  (setq org-hide-emphasis-markers t)

  (setq org-fontify-whole-heading-line t)
  (setq org-fontify-done-headline t)
  (setq org-fontify-quote-and-verse-blocks t)

  (setq org-highlight-latex-and-related '(native))

  (defun sk:org-toggle-emphasis-markers ()
    "toggle display of emphasis markers"
    (interactive)
    (org-toggle-link-display)
    (if org-hide-emphasis-markers
        (setq org-hide-emphasis-markers nil)
      (setq org-hide-emphasis-markers t))
    (org-restart-font-lock)
    (message "org: toggled display of emphasis markers"))

  (general-def org-mode-map
    "C-c C-x C-h" 'org-toggle-pretty-entities
    "C-c C-x H" 'sk:org-toggle-emphasis-markers)

  (add-hook 'org-mode-hook #'org-num-mode)
  (add-hook 'org-mode-hook #'org-indent-mode)
  (add-hook 'org-mode-hook #'org-toggle-pretty-entities)

; ** editing
; *** settings
  (setq org-blank-before-new-entry
        '((heading . t)
          (plain-list-item . nil)))

  (setq org-list-demote-modify-bullet
        '(("+" . "-")
          ("-" . "+")
          ("1." . "-")
          ("1)" . "-")))

  (setq org-emphasis-alist
        '(("*" bold)
          ("/" italic)
          ("_" underline)
          ("=" org-verbatim verbatim)
          ("~" org-code verbatim)))

; *** keybinds
  (defun sk:org-return ()
    "custom org-return. respects lists and tables like one would expect in a normal ms word-like editor"
    (interactive)
    (cond
     ((org-at-table-p)
      (org-table-insert-row '(4)))
     ((org-in-item-p)
      (if (save-excursion
            (beginning-of-line)
            (org-element-property :contents-begin (org-element-context)))
          (org-insert-item (org-at-item-checkbox-p))
        (delete-region (line-beginning-position) (line-end-position))
        (org-return)))
     (t
      (org-return))))

  ;; compatibility with sklatex linebreaks
  (advice-add 'org-return :after #'(lambda () (run-hooks 'post-self-insert-hook)))

  (general-def org-mode-map
    "C-c C-_" #'(lambda () (interactive) (org-cycle-list-bullet 'previous))
    "C-#" #'(lambda () (interactive) (insert "#"))

    "RET" 'sk:org-return
    "M-RET" 'org-ctrl-c-ctrl-c

    "M-h" 'org-metaleft
    "M-H" 'org-shiftmetaleft
    "M-j" 'org-metadown
    "M-J" 'org-shiftmetadown
    "M-k" 'org-metaup
    "M-K" 'org-shiftmetaup
    "M-l" 'org-metaright
    "M-L" 'org-shiftmetaright)

; ** narrowing
  ;; see `sk:narrow-or-widen' for regular src- / table-editing

  (setq org-src-window-setup 'plain)
  (setq display-buffer-alist '(("Org Src" . (display-buffer-same-window))))

  (defun sk:leader-E ()
    "determine and perform desired action on <leader>-E input"
    (interactive)
    (when (derived-mode-p 'org-mode)
      (let ((display-buffer-alist '(("Org Src" . (display-buffer-pop-up-window)))))
        (org-edit-special))))

  (general-def-leader
    "E" 'sk:leader-E)

; ** agenda, capture
; *** general settings
  (setq org-directory "~/.emacs.d/org-dir")
  (setq org-agenda-files '("~/.emacs.d/org-dir/"))
  (setq org-default-notes-file "~/.emacs.d/org-dir/notes.org")

  (setq vc-follow-symlinks t)
  (setq calendar-week-start-day 1)
  (setq org-agenda-window-setup 'current-window)

; *** agenda views
  (setq org-agenda-custom-commands
        '(("n" "Dashboard"
           ((agenda "" ((org-agenda-overriding-header "")
                        (org-agenda-span 'fortnight)
                        (org-agenda-skip-scheduled-if-done t)
                        (org-agenda-skip-deadline-if-done t)
                        (org-deadline-warning-days 0)
                        (org-agenda-use-time-grid nil)))
            (todo "" ((org-agenda-overriding-header "Unscheduled, Undeadlined Tasks")
                      (org-agenda-todo-ignore-scheduled t)
                      (org-agenda-todo-ignore-deadlines t)))
            (todo "DONE" ((org-agenda-overriding-header "Done Tasks"))))
           ((org-agenda-start-on-weekday nil)
            (org-agenda-block-separator "")
            (org-agenda-sorting-strategy '((agenda time-up priority-down alpha-up)
                                           (todo priority-down alpha-up)))
            (org-agenda-prefix-format
             '((agenda . "  %i %-12:c%?-12tEff.: %-8e %s")
               (todo . "  %i %-12:cEff.: %-8e")
               (tags . "  %i %-12:c")
               (search . "  %i %-12:c")))))))

; *** agenda keybinds
  (general-def org-agenda-mode-map
    "D" 'org-agenda-goto-date
    "g" 'org-agenda-redo
    "M" 'org-agenda-month-view
    "n" 'org-agenda-next-date-line
    "p" 'org-agenda-previous-date-line
    "P" 'org-agenda-set-property
    "q" 'org-agenda-exit
    "Q" 'org-agenda-quit
    "r" 'org-agenda-redo-all
    "W" 'org-agenda-fortnight-view)

; *** capture
  (setq org-bookmark-names-plist nil)
  (setq org-refile-targets '((org-agenda-files . (:maxlevel . 1))))
  (setq org-capture-templates '(("c" "TODO entry" entry (file "~/.emacs.d/org-dir/capture.org")
                                 "* TODO %?"
                                 :empty-lines 1)))

  (general-def org-capture-mode-map
    "C-c C-c" nil)

; ** image preview
  (defun sk:org-toggle-inline-images ()
    "toggle image previews in the region, if it is active, and the next image after point otherwise"
    (interactive)
    (let* ((beg (if (region-active-p)
                    (region-beginning)
                  (line-beginning-position)))
           (end (if (region-active-p)
                    (region-end)
                  (save-excursion
                    (beginning-of-line)
                    (re-search-forward "\\]\\]")
                    (line-end-position))))
           (overlays-in-region (seq-intersection (overlays-in beg end) org-inline-image-overlays)))
      (if overlays-in-region
          (mapc (lambda (ov)
                  (delete-overlay ov)
                  (setq org-inline-image-overlays (delete ov org-inline-image-overlays)))
                overlays-in-region)
        (org-display-inline-images t nil beg end)))
    (message "org-mode: toggled image preview"))

  (general-def org-mode-map
    "C-c C-x C-v" 'sk:org-toggle-inline-images
    "C-c C-x V" 'org-toggle-inline-images
    "C-c C-x M-v" 'org-redisplay-inline-images)

; ** latex settings
; *** math settings
  (add-to-list 'org-latex-packages-alist '("" "IEEEtrantools" t))
  (add-to-list 'org-latex-packages-alist '("" "gensymb" t))
  (add-to-list 'org-latex-packages-alist '("" "gauss" t))

; *** syntax table adjustments
  ;; prevent < and > from being interpreted as delimiters
  (add-hook 'org-mode-hook #'(lambda () (modify-syntax-entry ?< "@")))
  (add-hook 'org-mode-hook #'(lambda () (modify-syntax-entry ?> "@")))

  ;; for prettify compatibility, e. g. in \mathbb{N}^{+}
  (add-hook 'org-mode-hook #'(lambda () (modify-syntax-entry ?^ "_")))

  ;; other latex stuff (see 83--auctex.el for doc)
  (add-hook 'org-mode-hook #'(lambda () (modify-syntax-entry ?\\ "w")))
  (add-hook 'org-mode-hook #'(lambda () (modify-syntax-entry ?$ "$")))
  (add-hook 'org-mode-hook #'(lambda () (modify-syntax-entry ?| "$")))

; *** latex preview
  (setq sk:org-preview-latex-scale 1.5)
  (plist-put org-format-latex-options :scale sk:org-preview-latex-scale)

  (defun sk:org-preview-latex-scale-set (new-scale)
    "interactively reads a new latex preview scale"
    (interactive "nnew preview scale: ")
    (setq sk:org-preview-latex-scale new-scale)
    (plist-put org-format-latex-options :scale sk:org-preview-latex-scale)
    (message "latex preview scale set to %s" sk:org-preview-latex-scale))

  (defun sk:org-latex-preview-at-point ()
    "toggles preview of latex-code at point"
    (interactive)
    (if (or (org-in-block-p '("latex"))
            (org-in-regexp "\$.*\$"))
        (org-latex-preview)
      (message "not inside latex environment")))

  (general-def org-mode-map
    "C-c C-x L" 'sk:org-preview-latex-scale-set)

; ** org-babel
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((gnuplot . t)))
   ;;'((jupyter . t)))

  ;;(add-hook 'org-babel-after-execute-hook #'sk:org-toggle-inline-images-after-babel-run)

  (setq org-confirm-babel-evaluate nil)
  (setq org-edit-src-content-indentation 0)

  (defun sk:org-babel-kill-session-at-point ()
    (interactive)
    (kill-buffer (concat "*" (concat (nth 0 (org-babel-get-src-block-info)) "*"))))

  (defun sk:org-babel-eval-with-new-session ()
    (interactive)
    (sk:org-babel-kill-session-at-point)
    (org-ctrl-c-ctrl-c)))

; * ox (export pkgs)
(use-package ox
  :after org
  :config
  (setq org-latex-pdf-process '("latexmk -f -pdf -%latex -interaction=nonstopmode -shell-escape -output-directory=%o %f")))

(use-package ox-latex
  :after ox
  :config
  (add-to-list 'org-latex-classes '("report-nopart" "\\documentclass[11pt]{report}"
                                    ("\\chapter{%s}" . "\\chapter*{%s}")
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes '("scrlttr2" "\\documentclass[11pt]{scrlttr2}"
                                    ("\\chapter{%s}" . "\\chapter*{%s}")
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

; * org-superstar
(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("❃" "★" "✦" "☆" "✧" "•"))
  (setq org-superstar-item-bullet-alist '((42 . "•") (43 . (?\s (Bc . Bc) ?→)) (45 . "–"))))
