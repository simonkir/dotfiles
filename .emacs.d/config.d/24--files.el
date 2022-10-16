;;; -*- lexical-binding: t; -*-



(bind-keys :map sk:leader-map
  ("f f" . find-file)
  ("f F" . find-file-read-only)
  ("f p" . find-file-at-point)
  ("f R" . revert-buffer)
  ("f s" . save-buffer)
  ("f S" . save-some-buffers))

(bind-keys :map sk:leader-map
  ("s" . save-buffer))



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

  (bind-keys :map sk:leader-map
    ("f r" . sk:recentf-find-file))

  (recentf-mode t))
