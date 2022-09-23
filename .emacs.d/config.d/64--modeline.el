;;; -*- lexical-binding: t; -*-



(use-package telephone-line
  :demand t
  :config
  (set-face-attribute 'mode-line                      nil :background "#202328" :foreground "#bbc2cf")
  (set-face-attribute 'mode-line-inactive             nil :background "#282c34" :foreground "#bbc2cf")
  (set-face-attribute 'telephone-line-accent-inactive nil :background "#282c34" :foreground "#bbc2cf")
  (set-face-attribute 'telephone-line-accent-active   nil :background "#3f444a" :foreground "#bbc2cf")
  (set-face-attribute 'telephone-line-error           nil :background "#3f444a" :foreground "#ff6c6b")
  (set-face-attribute 'telephone-line-evil            nil :background "#282c34" :foreground "#bbc2cf")
  (set-face-attribute 'telephone-line-evil-emacs      nil :background "#ecbe7b" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-insert     nil :background "#98be65" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-normal     nil :background "#51afef" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-operator   nil :background "#46d9ff" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-replace    nil :background "#ff6c6b" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-visual     nil :background "#c678dd" :foreground "#282c34")
  (set-face-attribute 'telephone-line-warning         nil :background "#3f444a" :foreground "#e5c07b")



  (telephone-line-defsegment sk:tl-vc-file-segment ()
    (if (buffer-file-name)
        (let ((state (vc-state (buffer-file-name))))
          (cond
           ((eq state 'up-to-date) "·")
           ((eq state 'edited) "×")
           ((eq state 'needs-update) "u")
           ((eq state 'needs-merge) "c")
           (t "")))))

  (telephone-line-defsegment sk:tl-buffer-modified-segment ()
    (if (and (buffer-modified-p) (not buffer-read-only) (buffer-file-name))
        "×"
      ""))

  (telephone-line-defsegment sk:tl-dir-segment ()
    (if (buffer-file-name)
        (car (last (split-string (buffer-file-name) "/") 2))
      ""))

  (telephone-line-defsegment sk:tl-file-segment ()
    mode-line-buffer-identification)

  (telephone-line-defsegment sk:tl-visual-mode-segment ()
    (if (eq evil-state 'visual)
        (let ((beg (region-beginning))
              (end (region-end)))
          (format "%s/%s lines" (count-lines beg end) (count-lines beg end t)))
      ""))

  (telephone-line-defsegment sk:tl-position-percentage-segment ()
    (let* ((current-line (cond
                          ((derived-mode-p 'pdf-view-mode) (pdf-view-current-page))
                          (t (line-number-at-pos))))
           (max-lines (cond
                       ((derived-mode-p 'pdf-view-mode) (pdf-cache-number-of-pages))
                       (t (count-lines (point-min) (point-max)))))
           (percentage (/ (* 100 current-line) max-lines)))
      (concat (format "%s" percentage) "%%")))

  ;; TODO modeline doesn't update often enough to display changes in (current-column)
  (telephone-line-defsegment sk:tl-position-segment ()
    (cond
     ((derived-mode-p 'pdf-view-mode)
      (concat (format "%s" (pdf-view-current-page))
              "/"
              (format "%s" (pdf-cache-number-of-pages))))
     (t
      (concat (format "%s" (line-number-at-pos))
              ":"
              (format "%s" (current-column))))))

  (setq telephone-line-lhs
          '((evil   . (telephone-line-evil-tag-segment))
            (accent . (sk:tl-vc-file-segment
                       telephone-line-process-segment))
            (nil    . (sk:tl-buffer-modified-segment
                       sk:tl-dir-segment
                       sk:tl-file-segment))))

  (setq telephone-line-rhs
          '((nil    . (telephone-line-flycheck-segment
                       telephone-line-misc-info-segment
                       sk:tl-visual-mode-segment))
            (accent . (telephone-line-major-mode-segment))
            (evil   . (sk:tl-position-percentage-segment
                       sk:tl-position-segment))))



  (setq telephone-line-primary-left-separator     'telephone-line-identity-left)
  (setq telephone-line-secondary-left-separator   'telephone-line-identity-hollow-left)
  (setq telephone-line-primary-right-separator    'telephone-line-identity-right)
  (setq telephone-line-secondary-right-separator  'telephone-line-identity-hollow-right)

  (telephone-line-mode))