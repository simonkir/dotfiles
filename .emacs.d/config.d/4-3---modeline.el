;;; -*- lexical-binding: t; -*-



(use-package telephone-line
  :demand t
  :config
  (set-face-attribute 'mode-line                      nil :background "#21242b" :foreground "#abb2bf")
  (set-face-attribute 'mode-line-inactive             nil :background "#282c34" :foreground "#abb2bf")
  (set-face-attribute 'telephone-line-accent-inactive nil :background "#282c34" :foreground "#abb2bf")
  (set-face-attribute 'telephone-line-accent-active   nil :background "#3e4452" :foreground "#abb2bf")
  (set-face-attribute 'telephone-line-error           nil :background "#3e4452" :foreground "#e06c75")
  (set-face-attribute 'telephone-line-evil            nil :background "#282c34" :foreground "#abb2bf")
  (set-face-attribute 'telephone-line-evil-emacs      nil :background "#e5C07b" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-insert     nil :background "#98c379" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-normal     nil :background "#61afef" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-operator   nil :background "#56b6c2" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-replace    nil :background "#e06c75" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-visual     nil :background "#c678dd" :foreground "#282c34")
  (set-face-attribute 'telephone-line-warning         nil :background "#e5C07b" :foreground "#e5c07b")



  (telephone-line-defsegment sk:tl-vc-file-segment ()
    (let ((state (vc-state (buffer-file-name))))
      (cond
       ((eq state 'up-to-date) "·")
       ((eq state 'edited) "×")
       ((eq state 'needs-update) "u")
       ((eq state 'needs-merge) "c")
       (t ""))))

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

  (telephone-line-defsegment sk:tl-position-percentage-segment ()
    (let ((percentage (/ (* 100 (line-number-at-pos)) (count-lines (point-min) (point-max)))))
      (concat (format "%s" percentage) "%%")))

  ;; TODO modeline doesn't update often enough to display changes in (current-column)
  (telephone-line-defsegment sk:tl-position-segment ()
    (concat (format "%s" (line-number-at-pos))
            ":"
            (format "%s" (current-column))))

  (setq telephone-line-lhs
          '((evil   . (telephone-line-evil-tag-segment))
            (accent . (sk:tl-vc-file-segment
                       telephone-line-process-segment))
            (nil    . (sk:tl-buffer-modified-segment
                       sk:tl-dir-segment
                       sk:tl-file-segment))))

  (setq telephone-line-rhs
          '((nil    . (telephone-line-flycheck-segment
                       telephone-line-misc-info-segment))
            (accent . (telephone-line-major-mode-segment))
            (evil   . (sk:tl-position-percentage-segment
                       sk:tl-position-segment))))



  (setq telephone-line-primary-left-separator     'telephone-line-identity-left)
  (setq telephone-line-secondary-left-separator   'telephone-line-identity-hollow-left)
  (setq telephone-line-primary-right-separator    'telephone-line-identity-right)
  (setq telephone-line-secondary-right-separator  'telephone-line-identity-hollow-right)

  (telephone-line-mode))
