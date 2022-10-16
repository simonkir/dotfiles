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



(bind-keys :map sk:leader-map
  ("w o" . delete-other-windows)
  ("w 1" . delete-other-windows)
  ("w s" . sk:split-and-follow-horizontally)
  ("w v" . sk:split-and-follow-vertically)

  ("w 0"       . sk:resize-current-window)
  ("w <right>" . sk:resize-current-window)
  ("w <left>"  . sk:resize-current-window)
  ("w <up>"    . sk:resize-current-window)
  ("w <down>"  . sk:resize-current-window)
 
  ("w h" . windmove-left)
  ("w j" . windmove-down)
  ("w k" . windmove-up)
  ("w l" . windmove-right)
  ("w c" . delete-window)
  ("w C" . kill-buffer-and-window))

(bind-key "C-SPC" 'next-window-any-frame)



(use-package transpose-frame
  :bind (:map sk:leader-map
    ("w w" . transpose-frame)
    ("w r" . rotate-frame-clockwise)
    ("w R" . rotate-frame-anticlockwise)
    ("w F" . flip-frame)
    ("w f" . flop-frame)))
