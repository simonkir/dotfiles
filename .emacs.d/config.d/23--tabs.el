;;; -*- lexical-binding: t; -*-



(use-package centaur-tabs
  :init
  (if (daemonp)
      (add-hook 'server-after-make-frame-hook #'centaur-tabs-mode)
    (add-hook 'after-init-hook #'centaur-tabs-mode))

  :config
  (defun sk:centaur-tabs-buffer-groups ()
    '("Everything"))

  (defun sk:centaur-tabs-hide-tab (x)
    (let ((name (format "%s" x)))
      (cond
       ((window-dedicated-p (selected-window)) t)
       ((string-prefix-p "*dashboard*" name) nil)
       ((string-prefix-p "*eat*" name) nil)
       ((string-prefix-p "*Org Agenda*" name) nil)
       ((string-prefix-p "*maxima*" name) nil)
       ((string-prefix-p "CAPTURE-" name) t)
       ((string-prefix-p "magit" name) t)
       ((string-prefix-p "*" name) t)
       ((string-prefix-p " *" name) t))))

  (setq centaur-tabs-buffer-groups-function #'sk:centaur-tabs-buffer-groups)
  (setq centaur-tabs-hide-tab-function #'sk:centaur-tabs-hide-tab)

  ;;(centaur-tabs-enable-buffer-alphabetical-reordering)
  ;;(setq centaur-tabs-adjust-buffer-order t)

  (setq centaur-tabs-label-fixed-length 12)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-set-icons t)

  ;; disable centaur-tabs locally in these major modes
  ;;(add-hook 'dashboard-mode-hook #'centaur-tabs-local-mode)

  (general-def
    "C-<tab>" 'centaur-tabs-forward
    "C-<iso-lefttab>" 'centaur-tabs-backward))
