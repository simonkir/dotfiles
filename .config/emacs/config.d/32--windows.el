;;; -*- lexical-binding: t; -*-

; * sk:functions
(defun sk:split-and-follow-horizontally (arg)
  "create a horizontal split and change focus to newly split window

with ARG, dont balance windows afterwards"
  (interactive "P")
  (split-window-below)
  (unless arg
    (balance-windows))
  (other-window 1))

(defun sk:split-and-follow-vertically (arg)
  "create a vertical split and change focus to newly split window

with ARG, dont balance windows afterwards"
  (interactive "P")
  (split-window-right)
  (unless arg
    (balance-windows))
  (other-window 1))

(general-def-leader
  "w v" 'sk:split-and-follow-vertically
  "w V" 'sk:split-and-follow-horizontally
  "w =" 'balance-windows)

; * ace-window
(use-package ace-window
; ** keybinds
  :general
  ("C-SPC" 'sk:other-window
   "C-S-SPC" 'other-window)

  (general-def-leader
    "w c" 'sk:delete-window
    "w o" 'sk:delete-other-windows
    "w m" 'sk:swap-window)

  :config
; ** general config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-dispatch-alist '())
  (set-face-attribute 'aw-leading-char-face nil :foreground nil :inherit 'error)

  (ace-window-posframe-mode)

; ** sk:functions
  (defun sk:other-window ()
    "when there are more than 2 windows, seelct a window using ace-window. else, select the other window"
    (interactive)
    ;; no problems with default ace-swap-windows
    ;; own function due to consistency
    (let ((aw-dispatch-always nil))
      (ace-select-window)))

  (defun sk:delete-window (arg)
    "when there are more than 2 windows, delete a window using ace-window. else, delete the current window.

with prefix-arg, don't balance windows afterwards"
    (interactive "P")
    ;; problems with default ace-delete-window:
    ;; – with 2 windows, deletes the unselected one
    ;; – with 1 window, deletes the frame
    (if (> (count-windows) 2)
        (let ((aw-dispatch-always t))
          (ace-delete-window))
      (delete-window))
    (unless arg
      (balance-windows)))

  (defun sk:delete-other-windows ()
    "delete other windows using ace-window."
    (interactive)
    ;; problems with default ace-delete-other-windows:
    ;; – with 2 windows, doesnt ask which window should be kept
    (when (> (count-windows) 1)
      (let ((aw-dispatch-always t))
        (ace-delete-other-windows))))

  (defun sk:swap-window ()
    "when there are more than 2 windows, swap two windows using ace-window. else, swap both windows."
    (interactive)
    ;; no problems with default ace-swap-windows
    ;; own function due to consistency
    (let ((aw-dispatch-always nil))
      (ace-swap-window))))

; * transpose-frame
(use-package transpose-frame
  :general (general-def-leader
    "w w" 'transpose-frame
    "w r" 'rotate-frame-clockwise
    "w R" 'rotate-frame-anticlockwise
    "w S" 'flip-frame
    "w s" 'flop-frame))

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

