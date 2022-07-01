;;; -*- lexical-binding: t; -*-



(use-package telephone-line
  :demand t
  :config
  (set-face-attribute 'telephone-line-accent-inactive nil :background "#282c34" :foreground "#abb2bf")
  (set-face-attribute 'telephone-line-accent-active   nil :background "#3e4452" :foreground "#abb2bf")
  (set-face-attribute 'telephone-line-error           nil :background "#3e4452" :foreground "#e06c75")
  (set-face-attribute 'telephone-line-evil            nil :background "#282c34" :foreground "#abb2bf")
  (set-face-attribute 'telephone-line-evil-emacs      nil :background "#e5C07b" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-insert     nil :background "#98c379" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-normal     nil :background "#61afef" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-replace    nil :background "#e06c75" :foreground "#282c34")
  (set-face-attribute 'telephone-line-evil-visual     nil :background "#c678dd" :foreground "#282c34")
  (set-face-attribute 'telephone-line-warning         nil :background "#e5C07b" :foreground "#e5c07b")
  
  (setq telephone-line-lhs
          '((evil   . (telephone-line-evil-tag-segment))
            (accent . (telephone-line-vc-segment
                       telephone-line-process-segment))
            (nil    . (telephone-line-buffer-segment))))

  (setq telephone-line-rhs
          '((nil    . (telephone-line-flycheck-segment
                       telephone-line-misc-info-segment))
            (accent . (telephone-line-major-mode-segment))
            (evil   . (telephone-line-airline-position-segment))))

  (setq telephone-line-primary-left-separator     'telephone-line-identity-left)
  (setq telephone-line-secondary-left-separator   'telephone-line-identity-hollow-left)
  (setq telephone-line-primary-right-separator    'telephone-line-identity-right)
  (setq telephone-line-secondary-right-separator  'telephone-line-identity-hollow-right)

  (telephone-line-mode))
