;;; -*- lexical-binding: t; -*-



(global-auto-revert-mode)

;;(general-def '(normal visual) 'override
;;  "g r" 'revert-buffer-quick)



(defun sk:uniquify (base extra-string)
  (concat base " (" (mapconcat #'identity extra-string "/") ")"))

(setq uniquify-buffer-name-style 'sk:uniquify)



(setq sk:ignored-buffers-regexp "\\(^\\s-*\\*+\\)\\|\\(^magit\\)\\|\\(^\\s-*tq-temp-epdfinfo\\)")

(defun sk:buffer-list ()
  (let ((buffers (mapcar 'buffer-name (buffer-list))))
    (dolist (element buffers)
      (when (string-match-p sk:ignored-buffers-regexp element)
        (setq buffers (remove element buffers)))) ;; ensure element is deleted from buffers
    buffers))

(defun sk:switch-to-buffer ()
  (interactive)
  (switch-to-buffer (completing-read "Switch to buffer: " (sk:buffer-list)) t))

(defun sk:cycle-buffers (step)
  (let ((buffers (sk:buffer-list)))
    (when buffers
      ;; cycling logic
      (let (nextpos)
        (if (member (buffer-name) buffers)
            (setq nextpos (+ (cl-position (buffer-name) buffers) step))
          (setq nextpos 0))
        (when (>= nextpos (length buffers))
          (setq nextpos (- nextpos (length buffers))))
        (when (< nextpos 0)
          (setq nextpos (+ nextpos (length buffers))))
        (switch-to-buffer (nth nextpos buffers) t))
      ;; visualization in minibuffer
      (let ((minibuffer-message-timeout 10)
            (bmessage ""))
        (dolist (element buffers)
          (when (string= element (buffer-name))
            (setq element (propertize element 'face '(:weight bold :foreground "#98be65"))))
          (setq bmessage (concat bmessage element " / ")))
        (minibuffer-message "%s" (substring bmessage 0 -3))))))

(defun sk:next-buffer ()
  (interactive)
  (sk:cycle-buffers 1))

(defun sk:previous-buffer ()
  (interactive)
  (sk:cycle-buffers -1))

(defun sk:kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))



(bind-keys
  ("C-<tab>"         . sk:next-buffer)
  ("<C-iso-lefttab>" . sk:previous-buffer))

(bind-keys :map sk:leader-map
  ("b q" . bury-buffer)
  ("b h" . previous-buffer)
  ("b l" . next-buffer)
  ("b b" . sk:switch-to-buffer)
  ("b B" . switch-to-buffer)
  ("b k" . sk:kill-current-buffer)
  ("b K" . kill-buffer-and-window))
