;;; -*- lexical-binding: t; -*-



;; for dashboard package
(use-package all-the-icons
  :demand t
  :config (setq inhibit-compacting-font-caches nil))

(use-package svg-tag-mode
  :hook (org-mode org-agenda-mode)
  :config
  (defun sk:org-agenda-show-svg ()
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

  (setq sk:date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
  (setq sk:time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
  (setq sk:day-re "[A-Za-z]\\{2,3\\}")
  (setq sk:day-time-re (format "\\(%s\\)? ?\\(%s\\)?" sk:day-re sk:time-re))

  (setq svg-tag-tags
        `(
          ;; org todo items
          ("TODO" . ((lambda (tag) (svg-tag-make tag :radius 0 :face 'org-todo :inverse t))))
          ("DONE" . ((lambda (tag) (svg-tag-make tag :radius 0 :face 'org-done))))
          ("\\[ \\]" . ((lambda (tag) (svg-tag-make " " :padding 2 :radius 0 :face 'org-checkbox))))
          ("\\[-\\]" . ((lambda (tag) (svg-tag-make "⧖" :padding 1 :radius 0 :face 'org-checkbox))))
          ("\\[X\\]" . ((lambda (tag) (svg-tag-make "⨯" :padding 1 :radius 0 :face 'org-done))))

          ;; org "settings"
          ;;("#\\+[A-Za-z]+:" . ((lambda (tag) (svg-tag-make tag :radius 0 :beg 2 :end -1 :face 'org-meta-line))))

          ;; org priorities
          ("\\[#A\\]" . ((lambda (tag) (svg-tag-make tag :radius 0 :inverse t :beg 2 :end -1 :face 'error))))
          ("\\[#B\\]" . ((lambda (tag) (svg-tag-make tag :radius 0 :inverse t :beg 2 :end -1 :face 'org-todo))))
          ("\\[#C\\]" . ((lambda (tag) (svg-tag-make tag :radius 0 :inverse t :beg 2 :end -1 :face 'org-done))))

          ;; org date- / time- / duration stamps
          (,(format "<%s>" sk:date-re) . ((lambda (tag) (svg-tag-make tag :radius 0 :beg 1 :end -1))))
          (,(format "\\(<%s \\)%s>" sk:date-re sk:day-time-re) . ((lambda (tag) (svg-tag-make tag :radius 0 :beg 1 :inverse nil :crop-right t))))
          (,(format "<%s \\(%s>\\)" sk:date-re sk:day-time-re) . ((lambda (tag) (svg-tag-make tag :radius 0 :end -1 :inverse t :crop-left t))))

          ;; org-agenda
          ("Scheduled: \\|SCHEDULED: " . ((lambda (tag) (svg-tag-make tag :radius 0 :crop-right t :end -1 :face 'org-scheduled))))
          ("Deadline: \\|DEADLINE: " . ((lambda (tag) (svg-tag-make tag :radius 0 :inverse t :end -1 :face 'org-imminent-deadline))))

          ;; mby add progress bars ? (look into svg-tag-mode github exmaples)
          )))
