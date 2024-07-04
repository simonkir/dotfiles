;;; -*- lexical-binding: t; -*-

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
    '("Everything"))

  (defun sk:centaur-tabs-hide-tab (x)
    (let ((name (format "%s" x)))
      (cond
       ;; show agenda buffer, hide newly opened org-buffers
       ((ignore-error 'void-variable (member x org-agenda-new-buffers)) t)
       ((string-prefix-p "*Org Agenda*" name) nil)

       ;; explicitly show buffers
       ((string-prefix-p "*dashboard*" name) nil)
       ((string-prefix-p "*eat*" name) nil)
       ((string-prefix-p "*maxima*" name) nil)

       ;; hide buffers
       ((window-dedicated-p (selected-window)) t)
       ((string-prefix-p "CAPTURE-" name) t)
       ((string-prefix-p "magit" name) t)
       ((string-prefix-p "*" name) t)
       ((string-prefix-p " *" name) t))))

  (setq centaur-tabs-buffer-groups-function #'sk:centaur-tabs-buffer-groups)
  (setq centaur-tabs-hide-tab-function #'sk:centaur-tabs-hide-tab)

; ** keybinds
  (general-def
    "C-<tab>" 'centaur-tabs-forward
    "C-<iso-lefttab>" 'centaur-tabs-backward))

; * sk:functions
; ** definitions
(defun sk:kill-current-buffer ()
  "kills currently visited buffer"
  (interactive)
  (kill-buffer (current-buffer)))

; ** keybinds
(general-def-leader
  ;;"b b" nil ;; reserved for consult
  "b k" 'sk:kill-current-buffer
  "b K" 'kill-buffer-and-window)

; * auto-revert-mode
(global-auto-revert-mode)

; * uniquify
(defun sk:uniquify (base extra-string)
  (concat (mapconcat #'identity extra-string "/") ": " base))

(setq uniquify-buffer-name-style 'sk:uniquify)
