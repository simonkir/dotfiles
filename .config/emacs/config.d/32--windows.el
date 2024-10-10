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
  "w h" 'sk:split-and-follow-horizontally
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

; * centaur-tabs
(use-package centaur-tabs
; ** startup
  :init
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'centaur-tabs-mode)
    (add-hook 'after-init-hook #'centaur-tabs-mode))

  :config
; ** general settings
  (setq centaur-tabs-label-fixed-length 12)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-set-bar 'left)

  (setq centaur-tabs-icon-type 'nerd-icons)
  (setq centaur-tabs-set-icons t)

; ** tab grouping
  (defun sk:centaur-tabs-buffer-groups ()
    (let ((buffer (current-buffer))
          (name (buffer-name))
          (default '("1"))
          (semi-hidden '("5"))
          (hidden '("8")))
      (cond
       ;; explicitly show buffers
       ((string-prefix-p "*eat*" name) default)
       ((string-prefix-p "*Org Src" name) default)
       ((string-prefix-p "*Org Agenda*" name) default)

       ;; semi-hide buffers
       ((ignore-error 'void-variable (member buffer org-agenda-new-buffers)) semi-hidden)
       ((string-prefix-p "*tramp" name) semi-hidden)
       ((string-prefix-p "*Diff" name) semi-hidden)
       ((string-prefix-p "CAPTURE-" name) semi-hidden)
       ((string-prefix-p "magit" name) semi-hidden)

       ;; hide buffers
       ((window-dedicated-p (selected-window)) hidden)
       ((string-prefix-p "*" name) hidden)
       ((string-prefix-p " *" name) hidden)

       (t default))))

  (setq centaur-tabs-buffer-groups-function #'sk:centaur-tabs-buffer-groups)

; ** tab hiding
  (defun sk:centaur-tabs-hide-tab (buffer)
    nil)

  (setq centaur-tabs-hide-tabs-hooks nil)
  (setq centaur-tabs-hide-tab-function #'sk:centaur-tabs-hide-tab)

; ** keybinds
  (general-def
    "C-<tab>" 'centaur-tabs-forward-tab
    "C-<iso-lefttab>" 'centaur-tabs-backward-tab)

  (general-def-leader
    "w f" 'centaur-tabs-forward-tab
    "w b" 'centaur-tabs-backward-tab
    "w n" 'centaur-tabs-forward-group
    "w p" 'centaur-tabs-backward-group))

; * transpose-frame
(use-package transpose-frame
  :general (general-def-leader
    "w w" 'transpose-frame
    "w r" 'rotate-frame-clockwise
    "w R" 'rotate-frame-anticlockwise
    "w S" 'flip-frame
    "w s" 'flop-frame))

