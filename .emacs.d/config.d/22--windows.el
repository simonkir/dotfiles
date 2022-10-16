;;; -*- lexical-binding: t; -*-



(defun sk:resize-current-window ()
  (interactive)
  (cond
   ((eq last-command-event 'right) (call-interactively 'enlarge-window-horizontally))
   ((eq last-command-event 'left) (call-interactively 'shrink-window-horizontally))
   ((eq last-command-event 'up) (call-interactively 'shrink-window))
   ((eq last-command-event 'down) (call-interactively 'enlarge-window))
   ((eq last-command-event ?0) (call-interactively 'balance-windows)))
  (message "Use <left>, <right>, <up>, <down>, 0 for further adjustment")
  (set-transient-map
   (let ((map (make-sparse-keymap)))
     (dolist (key '(left right up down ?0))
       (define-key map (vector key) (lambda () (interactive) (sk:resize-current-window))))
     map)))

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



(general-def-leader
  "SPC w o" 'delete-other-windows
  "SPC w 1" 'delete-other-windows
  "SPC w s" 'sk:split-and-follow-horizontally
  "SPC w v" 'sk:split-and-follow-vertically
  
  "SPC w 0"       'sk:resize-current-window
  "SPC w <right>" 'sk:resize-current-window
  "SPC w <left>"  'sk:resize-current-window
  "SPC w <up>"    'sk:resize-current-window
  "SPC w <down>"  'sk:resize-current-window
  
  "SPC w h" 'windmove-left
  "SPC w j" 'windmove-down
  "SPC w k" 'windmove-up
  "SPC w l" 'windmove-right
  "SPC w c" 'delete-window
  "SPC w C" 'kill-buffer-and-window)

(general-def "C-SPC" 'next-window-any-frame)



(use-package transpose-frame
  :general (general-def-leader
    "SPC w w" 'transpose-frame
    "SPC w r" 'rotate-frame-clockwise
    "SPC w R" 'rotate-frame-anticlockwise
    "SPC w F" 'flip-frame
    "SPC w f" 'flop-frame))
