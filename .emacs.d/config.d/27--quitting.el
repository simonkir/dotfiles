;;; -*- lexical-binding: t; -*-



(defun sk:maybe-visit-unsaved-buffer ()
  "searches for unsaved file-visiting buffer. if there is one, switch to it

returns t of some buffers are unsaved, returns nil if all buffers are saved"
  (interactive)
  (let (unsaved-exists)
    (dolist (element (buffer-list))
      (when (and (buffer-modified-p element) (buffer-file-name element))
        (setq unsaved-exists t)
        (message "visiting unsaved buffer: %s" element)
        (switch-to-buffer element t)))
    (if unsaved-exists
        t
      nil)))

(defun sk:soft-quit ()
  "performes an soft quit of emacs

i. e. closing the terminal, unless there are unstaged changes"
  (interactive)
  (unless (sk:maybe-visit-unsaved-buffer)
    (save-buffers-kill-terminal)))

(defun sk:harsh-quit ()
  "performes an harsh quit of emacs

i. e. killing all open buffers and quitting the terminal, unless there are unstaged changes"
  (interactive)
  (unless (sk:maybe-visit-unsaved-buffer)
    (dolist (element (sk:buffer-list))
      (kill-buffer element))
    (save-buffers-kill-terminal)))



(bind-keys :map sk:leader-map
  ;;("ESC" . keyboard-escape-quit) ;; unknown what this binding is good for
  ("q"   . sk:soft-quit)
  ("Q"   . sk:harsh-quit))
