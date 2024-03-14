;;; -*- lexical-binding: t; -*-

; * sk:mode-line-diminish-mode
(define-minor-mode sk:mode-line-diminish-mode
  "sk:modeline-diminish minor mode. hides unimportant stuff"
  :global t
  (when sk:mode-line-diminish-mode
    (setq doom-modeline-enable-word-count nil)
    (which-function-mode 0)
    (display-time-mode 0))
  (unless sk:mode-line-diminish-mode
    (setq doom-modeline-enable-word-count t)
    (which-function-mode 1)
    (display-time-mode 1)))

(general-def sk:leader-map
  "d d" 'sk:mode-line-diminish-mode)

; * doom-modeline
(use-package doom-modeline
  :demand t
  :config
  (setq doom-modeline-height 26)
  (setq doom-modeline-bar-width 3)
  (setq doom-modeline-buffer-file-name-style 'truncate-upto-project)

  (setq doom-modeline-workspace-name nil)
  (setq doom-modeline-persp-name nil)
  (setq doom-modeline-buffer-encoding nil)
  (setq display-time-interval 1)
  (setq display-time-format "%H:%M:%S")
  (setq display-time-default-load-average nil)
  (line-number-mode 1)
  (column-number-mode 1)

  (sk:mode-line-diminish-mode 1)
  (doom-modeline-mode))
