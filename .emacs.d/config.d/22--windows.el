;;; -*- lexical-binding: t; -*-



(defun sk:split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun sk:split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))



(general-def '(normal visual) 'override :prefix "SPC w"
  "=" 'balance-windows
  "o" 'delete-other-windows
  "1" 'delete-other-windows
  "s" 'sk:split-and-follow-horizontally
  "v" 'sk:split-and-follow-vertically
 
  "h" 'evil-window-left
  "j" 'evil-window-down
  "k" 'evil-window-up
  "l" 'evil-window-right
  "c" 'evil-window-delete
  "C" 'kill-buffer-and-window)

(general-def 'normal 'override
  "SPC ," 'evil-window-next)

(general-def '(normal visual insert) 'override
  "C-SPC" 'evil-window-next)




(use-package transpose-frame
  :general ('(normal visual) 'override :prefix "SPC w"
    "w" 'transpose-frame
    "r" 'rotate-frame-clockwise
    "R" 'rotate-frame-anticlockwise
    "F" 'flip-frame
    "f" 'flop-frame))
