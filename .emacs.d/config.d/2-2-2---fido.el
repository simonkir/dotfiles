;;; -*- lexical-binding: t; -*-


(fido-mode)

(general-def 'normal 'override
  "SPC x" 'execute-extended-command)

(general-def icomplete-minibuffer-map
  "C-j" 'icomplete-forward-completions
  "C-k" 'icomplete-backward-completions)



(use-package icomplete-vertical
  :ensure t
  :demand t
  :config (icomplete-vertical-mode))
