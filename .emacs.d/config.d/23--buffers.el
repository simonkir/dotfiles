;;; -*- lexical-binding: t; -*-



(global-auto-revert-mode)

(general-def '(normal visual) 'override
  "g r" 'revert-buffer-quick)



(defun sk:uniquify (base extra-string)
  (concat base " (" (mapconcat #'identity extra-string "/") ")"))

(setq uniquify-buffer-name-style 'sk:uniquify)



(defun sk:switch-to-buffer ()
  (interactive)
  (let ((buffers (mapcar 'buffer-name (buffer-list))))
    (dolist (element buffers)
      (if (or (string-match-p "^\*+" element)
              (string-match-p "^\s-*" element)
              (string-match-p "^magit" element))
          (delete element buffers)))
    (switch-to-buffer (completing-read "Switch to buffer: " buffers))))

(defun sk:kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun sk:cycle-buffer (cycle-fun)
  (funcall cycle-fun)
  (while (or (and (string-match-p "^\*" (buffer-name))
                  (not (string-match-p "^\*Org Src" (buffer-name))))
             (string-match-p "^magit" (buffer-name)))
    (funcall cycle-fun)))

(defun sk:next-buffer ()
  (interactive)
  (sk:cycle-buffer 'next-buffer))

(defun sk:previous-buffer ()
  (interactive)
  (sk:cycle-buffer 'previous-buffer))



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