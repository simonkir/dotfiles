;;; -*- lexical-binding: t; -*-



(global-auto-revert-mode)



(defun sk:uniquify (base extra-string)
  (concat base " (" (mapconcat #'identity extra-string "/") ")"))

(setq uniquify-buffer-name-style 'sk:uniquify)



(setq sk:ignored-buffers-regexp "\\(^\\s-*\\*+\\)\\|\\(^magit\\)\\|\\(^\\s-*tq-temp-epdfinfo\\)")
(setq sk:unignored-buffers-regexp "\\*maxima\\*")
(setq sk:fallback-buffer "*dashboard*")

(defun sk:buffer-list ()
  "returns buffer-list without unimportant buffers (specified in `sk:ignored-buffers-regexp')"
  (let ((buffers (mapcar 'buffer-name (buffer-list))))
    (dolist (element buffers)
      (when (and (not (string-match-p sk:unignored-buffers-regexp element))
                 (string-match-p sk:ignored-buffers-regexp element))
        (setq buffers (remove element buffers)))) ;; ensure element is deleted from buffers
    (sort buffers 'string<)))

(defun sk:switch-to-buffer ()
  (interactive)
  (switch-to-buffer (completing-read "Switch to buffer: " (sk:buffer-list)) t))

(defun sk:cycle-buffers (step)
  (let ((buffers (sk:buffer-list)))
    (if buffers
        ;; cycle buffers
        (progn
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
            (minibuffer-message "%s" (substring bmessage 0 -3))))
      ;; visit fallback buffer if no buffers are open
      (switch-to-buffer sk:fallback-buffer)
      (minibuffer-message "%s" (propertize sk:fallback-buffer 'face '(:weight bold :foreground "#98be65"))))))

(defun sk:next-buffer ()
  (interactive)
  (sk:cycle-buffers 1))

(defun sk:previous-buffer ()
  (interactive)
  (sk:cycle-buffers -1))

(defun sk:kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))



(general-def
  "C-<tab>"         'sk:next-buffer
  "<C-iso-lefttab>" 'sk:previous-buffer)

(general-def-leader
  "b b" 'sk:switch-to-buffer
  "b B" 'switch-to-buffer
  "b k" 'sk:kill-current-buffer
  "b K" 'kill-buffer-and-window)
