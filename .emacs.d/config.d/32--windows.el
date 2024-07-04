;;; -*- lexical-binding: t; -*-

; * sk:functions
; ** resizing
(defun sk:resize-current-window ()
  "interactively resize the current window using the arrow keys

<left> / <right>: increase / decrease width
<up> / <down>: increase / decrease height
0 / =: balance windows"
  (interactive)
  (cond
   ((eq last-command-event 'right) (call-interactively #'enlarge-window-horizontally))
   ((eq last-command-event 'left) (call-interactively #'shrink-window-horizontally))
   ((eq last-command-event 'up) (call-interactively #'shrink-window))
   ((eq last-command-event 'down) (call-interactively #'enlarge-window))
   ((eq last-command-event ?0) (call-interactively #'balance-windows))
   ((eq last-command-event ?=) (call-interactively #'balance-windows)))
  (message "Use <left>, <right>, <up>, <down>, 0/= for further adjustment")
  (set-transient-map
   (let ((map (make-sparse-keymap)))
     (dolist (key '(left right up down ?0 ?=))
       (define-key map (vector key) (lambda () (interactive) (sk:resize-current-window))))
     map)))

; ** splitting
(defun sk:split-and-follow-horizontally ()
  "create a horizontal split and change focus to newly split window"
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun sk:split-and-follow-vertically ()
  "create a vertical split and change focus to newly split window"
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

; ** cycling
(defun sk:cycle-windows-forward ()
  "cycle visible windows forward"
  (interactive)
  (select-window (next-window (selected-window) nil (selected-frame)))
  (run-hooks 'window-configuration-change-hook))

(defun sk:cycle-windows-backward ()
  "cycle visible windows backward"
  (interactive)
  (select-window (previous-window (selected-window) nil (selected-frame)))
  (run-hooks 'window-configuration-change-hook))

; ** keybinds
(general-def-leader
  "w s" 'sk:split-and-follow-horizontally
  "w v" 'sk:split-and-follow-vertically

  "w ="       'balance-windows
  "w 0"       'balance-windows
  "w <right>" 'sk:resize-current-window
  "w <left>"  'sk:resize-current-window
  "w <up>"    'sk:resize-current-window
  "w <down>"  'sk:resize-current-window

  "w o" 'delete-other-windows
  "w 1" 'delete-other-windows
  "w c" 'delete-window
  "w C" 'kill-buffer-and-window)

(general-def
  "C-SPC" 'sk:cycle-windows-forward
  "C-S-SPC" 'sk:cycle-windows-backward)

; * transpose-frame
(use-package transpose-frame
  :general (general-def-leader
    "w w" 'transpose-frame
    "w r" 'rotate-frame-clockwise
    "w R" 'rotate-frame-anticlockwise
    "w F" 'flip-frame
    "w f" 'flop-frame))

