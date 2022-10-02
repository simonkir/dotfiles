;;; -*- lexical-binding: t; -*-




(global-auto-revert-mode)

(general-def '(normal visual) 'override
  "g r" 'revert-buffer-quick)



(defun sk:uniquify (base extra-string)
  (concat base " (" (mapconcat #'identity extra-string "/") ")"))

(setq uniquify-buffer-name-style 'sk:uniquify)



(setq sk:ignored-buffers-regexp "^\\s-*\\*+\\|^magit")

(defun sk:buffer-list ()
  (let ((buffers (mapcar 'buffer-name (buffer-list))))
    (dolist (element buffers)
      (when (string-match-p sk:ignored-buffers-regexp element)
        (setq buffers (remove element buffers)))) ;; ensure element is deleted from buffers
    buffers))

(defun sk:switch-to-buffer ()
  (interactive)
  (switch-to-buffer (completing-read "Switch to buffer: " (sk:buffer-list))))

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
      (let ((bmessage ""))
        (dolist (element buffers)
          (when (string= element (buffer-name))
            (setq element (propertize element 'face '(:weight bold :foreground "#98be65"))))
          (setq bmessage (concat bmessage element " / ")))
        (message "%s" (substring bmessage 0 -3))))))

(defun sk:next-buffer ()
  (interactive)
  (sk:cycle-buffers 1))

(defun sk:previous-buffer ()
  (interactive)
  (sk:cycle-buffers -1))

(defun sk:kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))



(general-def '(normal visual insert) 'override
  ;;"C-w" 'bury-buffer ;; useful when using tab-line-mode
  "C-<tab>"         'sk:next-buffer
  "<C-iso-lefttab>" 'sk:previous-buffer)

(general-def '(normal visual) 'override :prefix "SPC b"
  "q" 'bury-buffer
  "h" 'previous-buffer
  "l" 'next-buffer
  "b" 'sk:switch-to-buffer
  "B" 'switch-to-buffer
  "k" 'sk:kill-current-buffer
  "K" 'kill-buffer-and-window)
