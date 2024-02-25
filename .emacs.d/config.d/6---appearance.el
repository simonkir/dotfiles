;;; -*- lexical-binding: t; -*-



(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)



(global-hl-line-mode 1)
(global-visual-line-mode 1)



;; display visual line numbers left of each buffer
(setq display-line-numbers-type 'visual)
(set-face-attribute 'line-number nil :foreground "#5b6268")
(global-display-line-numbers-mode 1)



; text scale ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def-leader
  "0" 'text-scale-adjust
  "+" 'text-scale-adjust
  "-" 'text-scale-adjust)
