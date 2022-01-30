;;; -*- lexical-binding: t; -*-



; snippets ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :ensure t
  :demand t
  :config
  (yas-global-mode)

  ; whitespace removing functions from Magnar Sveen ;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun yas-s-trim-left (s)
    "Remove whitespace at the beginning of S."
    (if (string-match "\\`[ \t\n\r]+" s)
        (replace-match "" t t s)
      s))
  
  (defun yas-s-trim-right (s)
    "Remove whitespace at the end of S."
    (if (string-match "[ \t\n\r]+\\'" s)
        (replace-match "" t t s)
      s))
  
  (defun yas-s-trim (s)
    "Remove whitespace at the beginning and end of S."
    (yas-s-trim-left (yas-s-trim-right s)))
  
  (defun yas-string-reverse (str)
    "Reverse a string STR manually to be compatible with emacs versions < 25."
    (apply #'string
           (reverse
            (string-to-list str))))
  
  (defun yas-trimmed-comment-start ()
    "This function returns `comment-start' trimmed by whitespaces."
    (yas-s-trim comment-start))
  
  (defun yas-trimmed-comment-end ()
    "This function returns `comment-end' trimmed by whitespaces if `comment-end' is not empty.
  Otherwise the reversed output of function `yas-trimmed-comment-start' is returned."
    (if (eq (length comment-end) 0)
        (yas-string-reverse (yas-trimmed-comment-start))
      (yas-s-trim comment-end)))) 



; templates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package autoinsert
  :demand t
  :config
  (setq auto-insert t)
  (setq auto-insert-directory "~/.emacs.d/templates/")
  (define-auto-insert 'org-mode "org-mode.org")
  (auto-insert-mode t))
