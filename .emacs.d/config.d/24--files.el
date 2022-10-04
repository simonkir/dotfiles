;;; -*- lexical-binding: t; -*-



(general-def '(normal visual) 'override
  "SPC f f" 'find-file
  "SPC f F" 'find-file-read-only
  "SPC f p" 'find-file-at-point
  "SPC f R" 'revert-buffer
  "SPC f s" 'save-buffer
  "SPC f S" 'save-some-buffers)

(general-def '(normal visual) 'override
  "SPC s" 'save-buffer)



(use-package recentf
  :demand t ;; needed for dashboard
  :config
  (setq recentf-max-saved-items 300)
  (add-to-list 'recentf-exclude (expand-file-name "~/.emacs.d/*"))
  (add-to-list 'recentf-exclude (expand-file-name "/usr/share/emacs/*"))
  (add-to-list 'recentf-exclude ".*/0---org.org")
  (add-to-list 'recentf-exclude ".*/0---misc.org")
  (add-to-list 'recentf-exclude ".*/0---glossar.org")
  (add-to-list 'recentf-exclude ".*/0---aufgaben.tex")
  (add-to-list 'recentf-exclude ".*/0---aufgaben.pdf")
  (add-to-list 'recentf-exclude ".*/0---mitschrieb.tex")
  (add-to-list 'recentf-exclude ".*/0---mitschrieb.pdf")

  (defun sk:recentf-find-file ()
    "Find a recent file using completing-read."
    (interactive)
    (let ((file (completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))

  (general-def '(normal visual) 'override
    "SPC f r" 'sk:recentf-find-file)

  (recentf-mode t))
