;;; -*- lexical-binding: t; -*-



(use-package flyspell
  :defer t
  :config
  (setq flyspell-issue-message-flag nil)
  (setq ispell-dictionary "de_DE")
  (defun sk:toggle-flyspell-mode ()
    (interactive)
    (if (bound-and-true-p flyspell-mode)
        (flyspell-mode 0)
      (flyspell-mode 1)
      (flyspell-buffer)))

  (general-def 'normal 'override :prefix "SPC i"
	"i" 'sk:toggle-flyspell-mode
	"d" 'ispell-change-dictionary
	"c" 'flyspell-check-previous-highlighted-word
	"j" 'evil-next-flyspell-error
	"k" 'evil-prev-flyspell-error))
