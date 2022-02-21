;;; -*- lexical-binding: t; -*-



;;(use-package ido
;;  :demand t
;;  :config
;;  (setq ido-enable-flex-matching t)
;;  ;;(setq ido-use-virtual-buffers 'auto)
;;  (setq ido-create-new-buffer 'always)
;;  (setq ido-everywhere t)
;;
;;  (defun sk:ido-custom-keys ()
;;    (general-def ido-completion-map
;;         "C-d" 'ido-kill-buffer-at-head
;;         "C-j" 'ido-next-match
;;         "C-k" 'ido-prev-match))
;;  (add-hook 'ido-setup-hook 'sk:ido-custom-keys)
;;
;;
;;
;;  ; ignoring buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  (add-to-list 'ido-ignore-buffers "^\*")
;;  (add-to-list 'ido-ignore-buffers "^magit")
;;
;;
;;
;;  ; recentf ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  (defun sk:recentf-ido-find-file ()
;;    "Find a recent file using Ido."
;;    (interactive)
;;    (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
;;      (when file
;;        (find-file file))))
;;
;;
;;
;;  ; bookmarks ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  (defun sk:ido-bookmark-jump (bname)
;;    "Switch to bookmark interactively using `ido'."
;;    (interactive (list (ido-completing-read "Bookmark: " (bookmark-all-names) nil t)))
;;    (bookmark-jump bname))
;;
;;  (ido-mode 1))
;;
;;
;;
;;(use-package ido-vertical-mode
;;  :after ido
;;  :ensure t
;;  :config (ido-vertical-mode 1))
