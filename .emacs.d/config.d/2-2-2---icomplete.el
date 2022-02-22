;;; -*- lexical-binding: t; -*-



(use-package icomplete
  :demand t
  :config
  ;; needed because icomplete--fido-mode-setup overwrites default settings
  (add-hook 'icomplete-minibuffer-setup-hook
            (lambda () (setq-local completion-styles '(basic partial-completion substring initials flex))))

  (setq read-file-name-completion-ignore-case t)
  (setq read-buffer-completion-ignore-case t)
  (setq completion-ignore-case t)
  (setq icomplete-compute-delay 0)

  (general-def icomplete-minibuffer-map
    "C-<return>" 'icomplete-fido-ret
    "C-d" 'icomplete-fido-kill
    "C-j" 'icomplete-forward-completions
    "C-k" 'icomplete-backward-completions)

  (general-def 'normal 'override
    "SPC x" 'execute-extended-command)

  (fido-mode))



(use-package icomplete-vertical
  :ensure t
  :after icomplete
  :config (icomplete-vertical-mode))
