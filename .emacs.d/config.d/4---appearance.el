;;; -*- lexical-binding: t; -*-



(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; display line / column numbers in modeline
(line-number-mode 1)
(column-number-mode 1)

;; display visual line numbers left of each buffer
(setq display-line-numbers-type 'visual)
(global-display-line-numbers-mode 1)
(global-visual-line-mode)
