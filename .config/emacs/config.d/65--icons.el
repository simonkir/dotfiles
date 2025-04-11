;;; -*- lexical-binding: t; -*-

; * general settings
;; better glyph & icon rendering performance
(setq inhibit-compacting-font-caches nil)

; * nerd-icons
; ** base package
(use-package nerd-icons :demand t)

; ** nerd-icons-completion (minibuffer icons)
(use-package nerd-icons-completion
  :demand t
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup)
  (nerd-icons-completion-mode))

; ** nerd-icons-corfu
(use-package nerd-icons-corfu
  :demand t
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

; * svg-tag-mode
(use-package svg-tag-mode
  :hook (org-mode org-agenda-mode)
  :config
; ** agenda hack
  (defun sk:org-agenda-show-svg ()
    "show svg-tags inside org-agenda views. hack copied from svg-tag-mode README"
    (let* ((case-fold-search nil)
           (keywords (mapcar #'svg-tag--build-keywords svg-tag--active-tags))
           (keyword (car keywords)))
      (while (and svg-tag-mode keyword)
        (save-excursion
          (while (re-search-forward (nth 0 keyword) nil t)
            (overlay-put (make-overlay
                          (match-beginning 0) (match-end 0))
                         'display  (nth 3 (eval (nth 2 keyword)))) ))
        (pop keywords)
        (setq keyword (car keywords)))))

  (add-hook 'org-agenda-finalize-hook #'sk:org-agenda-show-svg)

; ** icon definition
  (let* ((date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
         (time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
         (day-re "[A-Za-z]\\{2,3\\}")
         (day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re)))
    (setq svg-tag-tags
          `(
            ;; org todo items
            ("PREP" . ((lambda (tag) (svg-tag-make tag :radius 0 :face 'org-upcoming-distant-deadline))))
            ("TODO" . ((lambda (tag) (svg-tag-make tag :radius 0 :face 'org-todo :inverse t))))
            ("POST" . ((lambda (tag) (svg-tag-make tag :radius 0 :face 'org-todo))))
            ("DONE" . ((lambda (tag) (svg-tag-make tag :radius 0 :face 'org-done :inverse t))))
            ("\\[#A\\]" . ((lambda (tag) (svg-tag-make tag :radius 0 :inverse t :beg 2 :end -1 :face 'error))))
            ("\\[#B\\]" . ((lambda (tag) (svg-tag-make tag :radius 0 :inverse t :beg 2 :end -1 :face 'org-todo))))
            ("\\[#C\\]" . ((lambda (tag) (svg-tag-make tag :radius 0 :inverse t :beg 2 :end -1 :face 'org-done))))

            ;; org checkboxes
            ("\\[ \\]" . ((lambda (tag) (svg-tag-make "" :padding 2 :radius 0 :face 'org-checkbox))))
            ("\\[-\\]" . ((lambda (tag) (svg-tag-make "⧖" :padding 1 :radius 0 :face 'org-checkbox))))
            ;; ("\\[X\\]" . ((lambda (tag) (svg-tag-make "✔" :padding 1 :radius 0 :face 'org-done))))
            ("\\[X\\]" . ((lambda (tag) (svg-tag-make "✘" :padding 1 :radius 0 :face 'org-done))))

            ;; org date- / time- / duration stamps
            (,(format "<%s>" date-re) . ((lambda (tag) (svg-tag-make tag :radius 0 :beg 1 :end -1))))
            (,(format "\\(<%s \\)%s>" date-re day-time-re) . ((lambda (tag) (svg-tag-make tag :face 'org-scheduled :radius 0 :beg 1 :crop-left t :crop-right t))))
            (,(format "<%s \\(%s>\\)" date-re day-time-re) . ((lambda (tag) (svg-tag-make tag :face 'org-scheduled :radius 0 :end -1 :crop-left t))))

           ;; org-agenda / regular org-files
            ("Deadlined: \\|DEADLINE: " . ((lambda (tag) (svg-tag-make tag :end -1 :radius 0 :inverse t :face 'org-imminent-deadline))))
            ("Scheduled: \\|SCHEDULED: " . ((lambda (tag) (svg-tag-make tag :end -1 :inverse t :radius 0 :face 'org-scheduled)))))))

; ** keybinds
  (general-def-leader
    "d s" 'svg-tag-mode))
