;;; -*- lexical-binding: t; -*-



(defalias 'yes-or-no 'y-or-n-p)
(defalias 'yes-or-no-p 'y-or-n-p)



(use-package which-key
  :defer 4
  :ensure t
  :config
  (which-key-mode))



(use-package ido
  :demand t

  :custom
  (ido-enable-flex-matching nil)
  (ido-create-new-buffer 'always)
  (ido-everywhere t)

  :config
  (defun sk:ido-custom-keys ()
    (general-def ido-completion-map
         "C-d" 'ido-kill-buffer-at-head
         "C-n" 'ido-next-match
         "C-j" 'ido-next-match
         "C-k" 'ido-prev-match
         "C-p" 'ido-prev-match))
  (add-hook 'ido-setup-hook 'sk:ido-custom-keys)

  (setq sk:ido-unignored-buffers '("*dashboard*"))
  (defun sk:ido-ignore-buffers-fun (name)
    "Ignore all *starred* buffers except the ones listed in sk:ido-unignored-buffers"
    (and (string-match "^\*" name)
        (not (member name sk:ido-unignored-buffers))))
  (add-to-list 'ido-ignore-buffers 'sk:ido-ignore-buffers-fun)

  (defun recentf-ido-find-file ()
    "Find a recent file using Ido."
    (interactive)
    (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))

  (defun ido-bookmark-jump (bname)
    "Switch to bookmark interactively using `ido'."
    (interactive (list (ido-completing-read "Bookmark: " (bookmark-all-names) nil t)))
    (bookmark-jump bname))
  (add-hook 'after-init-hook 'bookmark-save)

  (ido-mode 1)

  (general-def 'normal 'override
    "SPC b b" 'ido-switch-buffer))

(use-package ido-vertical-mode
  :after ido
  :ensure t
  :config
  (ido-vertical-mode 1))

(use-package smex
  :after ido
  :ensure t
  :config
  (smex-initialize)

  :general
  ("M-x" 'smex)
  ('normal 'override "SPC x" 'smex))
