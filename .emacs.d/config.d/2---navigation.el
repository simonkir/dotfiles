;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default use-dialog-box nil)



(use-package which-key
  :demand t
  :config (which-key-mode))



; quitting ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun sk:save-buffers-kill-buffers-kill-terminal ()
  (interactive)
  (save-some-buffers)
  (let ((buffers (mapcar 'buffer-name (buffer-list))))
    (dolist (element buffers)
      (if (not (string-match-p sk:ignored-buffers-regexp element))
          (kill-buffer element))))
  (save-buffers-kill-terminal))

(general-def '(normal visual) 'override
  "SPC ESC" 'keyboard-escape-quit
  "SPC q"   'save-buffers-kill-terminal
  "SPC Q"   'sk:save-buffers-kill-buffers-kill-terminal)



; help ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(general-def '(normal visual) 'override
  "SPC h p" 'describe-package
  "SPC h f" 'describe-function
  "SPC h v" 'describe-variable
  "SPC h k" 'describe-key)
