;;; -*- lexical-binding: t; -*-

; * helper functions
(defun sk:kill-all-terminals ()
  "kill the currently active terminals"
  (interactive)
  (recentf-save-list)
  (if (frame-parameter nil 'client)
      (progn (delete-other-frames) (delete-frame))
    (kill-emacs)))

; * sk:soft-quit
(defun sk:soft-quit ()
  "performes an soft quit of emacs, i. e. closing all frames"
  (interactive)
  (save-some-buffers)
  (sk:kill-all-terminals))

; * sk:harsh-quit
(defun sk:harsh-quit ()
  "performes an harsh quit of emacs, i. e. killing all open buffers and closing all frames"
  (interactive)
  (save-some-buffers)
  (let ((kill-buffer-query-functions nil))
   (dolist (buffer (buffer-list))
     (set-buffer-modified-p nil)
     (kill-buffer buffer)))
  (sk:kill-all-terminals))

; * sk:daemon-quit
(defun sk:daemon-quit ()
  "performes an daemon quit of emacs, i. e. killing and restarting the emacs process"
  (interactive)
  (when (yes-or-no-p "Really perform sk:daemon-quit? ")
    (save-some-buffers)
    (kill-emacs nil t)))

; * keybinds
(general-def-leader
  "q" 'sk:soft-quit
  "Q" 'sk:harsh-quit
  "!" 'sk:daemon-quit)

(general-def "C-x C-c" nil)
