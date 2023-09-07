;;; -*- lexical-binding: t; -*-



(general-def-leader
  "f f" 'find-file
  "f R" 'revert-buffer-quick
  "f s" 'save-buffer
  "s"   'save-buffer)



(defun sk:cpwd ()
  "print and copy current working directory to system clipboard"
  (interactive)
  (gui-set-selection 'CLIPBOARD default-directory)
  (message "%s" default-directory))

(general-def-leader
  "d c" 'sk:cpwd)



(use-package recentf
  :demand t ;; needed for dashboard
  :config
  (setq recentf-max-saved-items 300)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/elpa/*"))
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
    "f r" 'sk:recentf-find-file)

  (recentf-mode t))
