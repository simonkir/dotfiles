;;; -*- lexical-binding: t; -*-



(general-def-leader
  "SPC f f" 'find-file
  "SPC f F" 'find-file-read-only
  "SPC f p" 'find-file-at-point
  "SPC f R" 'revert-buffer
  "SPC f s" 'save-buffer
  "SPC f S" 'save-some-buffers)

(general-def-leader
  "SPC s" 'save-buffer)



(use-package recentf
  :demand t ;; needed for dashboard
  :config
  (setq recentf-max-saved-items 300)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/*"))
  (add-to-list 'recentf-exclude (expand-file-name "/usr/share/emacs/*"))
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*org.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*misc.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*glossar.org")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*aufgaben.tex")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*aufgaben.pdf")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*mitschrieb.tex")
  (add-to-list 'recentf-exclude "^.*/[[:digit:]]*-*mitschrieb.pdf")

  (defun sk:recentf-find-file ()
    "Find a recent file using completing-read."
    (interactive)
    (let ((file (completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))

  (general-def-leader
    "SPC f r" 'sk:recentf-find-file)

  (recentf-mode t))
