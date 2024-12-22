;;; -*- lexical-binding: t; -*-

; * sk:functions
(defun sk:kill-this-buffer ()
  "unconditionally kill the current buffer"
  (interactive)
  (kill-buffer (current-buffer)))

(general-def-leader
  ;;"b b" nil ;; reserved for consult
  "b k" 'sk:kill-this-buffer
  "b K" 'kill-buffer-and-window)

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

; * uniquify
(defun sk:uniquify (base extra-string)
  (concat (mapconcat #'identity extra-string "/") ": " base))

(setq uniquify-buffer-name-style 'sk:uniquify)

