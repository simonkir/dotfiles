;;; -*- lexical-binding: t; -*-

; * helper-functions
(defun sk:maybe-save-all-buffers ()
  "searches for unsaved file-visiting buffer.
if there is one, switch to it and prompt whether to save, not save or abort current action

returns t if all buffers are saved"
  (interactive)
  (let (unsaved-buffers
        decision
        (abort nil))
    (dolist (element (buffer-list))
      (when (and (buffer-modified-p element) (buffer-file-name element))
        (switch-to-buffer element t)
        (setq decision (read-char (concat "unsaved buffer: " (buffer-name element) ". [s]ave, [i]gnore, [a]bort?")))
        (cond
         ((eq decision ?s) (save-buffer))
         ((eq decision ?i) nil)
         (t (setq abort t)))))
    (not abort)))

; * sk:soft-quit
(defun sk:soft-quit ()
  "performes an soft quit of emacs

i. e. closing the terminal, unless there are unsaved changes"
  (interactive)
  (when (sk:maybe-save-all-buffers)
    (save-buffers-kill-terminal)))

; * sk:harsh-quit
(defun sk:harsh-quit ()
  "performes an harsh quit of emacs

i. e. killing all open buffers and quitting the terminal, unless there are unsaved changes"
  (interactive)
  (when (sk:maybe-save-all-buffers)
    (dolist (element (centaur-tabs-buffer-list))
      (unless (string= (buffer-name element) "*dashboard*")
        (kill-buffer element)))
    (save-buffers-kill-terminal)))

; * sk:daemon-quit
(defun sk:daemon-quit ()
  "performes an daemon quit of emacs

i. e. killing the terminal, unless there are unsaved changes"
  (interactive)
  (when (yes-or-no-p "Really perform sk:daemon-quit? ")
    (when (sk:maybe-save-all-buffers)
      (kill-emacs nil t))))

; * keybinds
(general-def-leader
  "q" 'sk:soft-quit
  "Q" 'sk:harsh-quit
  "!" 'sk:daemon-quit)

(general-def "C-x C-c" nil)
