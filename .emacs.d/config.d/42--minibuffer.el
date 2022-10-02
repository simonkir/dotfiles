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
  (setq completion-auto-help 'lazy)
  (setq icomplete-compute-delay 0)

  (set-face-attribute 'icomplete-selected-match nil
                      :inherit    'default
                      :weight     'bold
                      :foreground "#98be65")

  (general-def '(normal insert) icomplete-minibuffer-map
    "C-<return>" 'icomplete-fido-ret
    "S-<return>" 'icomplete-fido-exit
    "C-d"        'icomplete-fido-kill
    "C-e"        'end-of-line
    "C-a"        'beginning-of-line
    "C-j"        'icomplete-forward-completions
    "C-k"        'icomplete-backward-completions)

  (general-def '(normal visual) 'override
    "SPC t i" 'fido-mode
    "SPC x"   'execute-extended-command)

  (fido-mode)
  (fido-vertical-mode))
