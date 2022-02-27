;;; -*- lexical-binding: t; -*-



;; display line / column numbers in modeline
(line-number-mode 1)
(column-number-mode 1)

;; display visual line numbers left of each buffer
(setq display-line-numbers-type 'visual)

;;(set-face-attribute 'line-number nil :foreground "#5b6268")
(set-face-attribute 'line-number nil :foreground "#4c5259")

(global-display-line-numbers-mode 1)
(global-visual-line-mode)
