;; -*- lexical-binding: t; -*-

; * meow
(use-package meow
  :demand t
  :config

; ** general settings
  (setq meow-use-cursor-position-hack t)
  (setq meow-expand-hint-remove-delay 1.5)
  (setq meow-display-thing-help nil)

  (setq meow-expand-exclude-mode-list nil)
  (setq meow-mode-state-list '((org-agenda-mode . motion)
                               (eat-mode . insert)))

; ** keypad settings
  (setq meow-keypad-start-keys '((?c . ?c) (?u . ?u) (?x . ?x)))
  (setq meow-keypad-meta-prefix ?m)
  (setq meow-keypad-literal-prefix ?\s)
  (setq meow-keypad-ctrl-meta-prefix nil)
  (setq meow-keypad-self-insert-undefined nil)
  (setq meow-keypad-leader-dispatch sk:leader-map)
  (setq meow-keypad-describe-delay most-positive-fixnum)

; ** helper functions
  (defun sk:meow-digit-argument-or-eval ()
    "when there is a region, act like eval, otherwise use digit-argument"
    (interactive)
    (let ((digit (- last-command-event ?0)))
      (if (or (< digit 0) (> digit 9))
          (message "digit not in range (digit = %s)" digit)
        (if (region-active-p)
            (meow-expand digit)
          (call-interactively #'meow-digit-argument)))))

  (defun sk:toggle-case ()
    "toggles case of char at / after point"
    (interactive)
    (let* ((beg (point))
           (end (1+ (point)))
           (letter (char-after beg))
           (upcased (eq letter (upcase letter)))
           (f (if upcased #'downcase-region #'upcase-region)))
      (funcall f beg end)
      (forward-char)))

; ** keybinds
  (general-def meow-insert-state-keymap
    "C-z" 'meow-motion-mode)

  (general-def meow-motion-state-keymap
    "<escape>" nil
    "C-z" 'meow-normal-mode
    "j" 'meow-next
    "k" 'meow-prev)

  (general-def meow-normal-state-keymap
    "0" 'sk:meow-digit-argument-or-eval
    "9" 'sk:meow-digit-argument-or-eval
    "8" 'sk:meow-digit-argument-or-eval
    "7" 'sk:meow-digit-argument-or-eval
    "6" 'sk:meow-digit-argument-or-eval
    "5" 'sk:meow-digit-argument-or-eval
    "4" 'sk:meow-digit-argument-or-eval
    "3" 'sk:meow-digit-argument-or-eval
    "2" 'sk:meow-digit-argument-or-eval
    "1" 'sk:meow-digit-argument-or-eval
    ;; "!" nil ;; reserved for jinx
    ;; "\"" nil
    ;; "§" nil
    ;; "$" nil
    ;;"%" nil ;; reserved for skparens
    ;; "&" nil
    ;; "/" nil
    "(" 'backward-sexp
    ")" 'forward-sexp
    "=" 'indent-region
    ;; "?" nil ;; reserved for jinx

    "#" 'comment-or-uncomment-region
    "~ ~" 'sk:toggle-case
    "~ c" 'capitalize-dwim
    "~ l" 'downcase-dwim
    "~ u" 'upcase-dwim
    "-" 'negative-argument
    ";" 'meow-reverse
    ":" 'recenter-top-bottom
    "*" 'meow-block
    "<" 'meow-beginning-of-thing
    ">" 'meow-end-of-thing
    "C-z" 'meow-motion-mode

    "a" 'meow-append
    ;; "A" nil ;; reserved for skparens
    "b" 'meow-back-word
    "B" 'meow-back-symbol
    "c" 'meow-join
    "C" 'beginning-of-line
    "d" 'meow-kill
    ;; "D" nil ;;reserved for skparens
    "e" 'meow-next-word
    "E" 'meow-next-symbol
    "f" 'meow-find
    ;;"F" nil
    ;;"g" nil ;; reserved for avy
    "G" 'meow-grab
    "h" 'meow-left
    "H" 'meow-left-expand
    "i" 'meow-insert
    ;;"I" nil ;; reserved for skparens
    "j" 'meow-next
    "J" 'meow-next-expand
    "k" 'meow-prev
    "K" 'meow-prev-expand
    "l" 'meow-right
    "L" 'meow-right-expand
    "m" 'meow-line
    ;; "M" nil ;; reserved for consult
    "n" 'meow-search
    ;;"N" nil
    "o" 'meow-open-below
    "O" 'meow-open-above
    "p" 'meow-yank
    ;;"P" nil ;; reserved for consult
    ;;"q" nil ;; reserved for buffer-local stuff (e. g. quitting *Help* buffers)
    ;;"Q" nil
    ;; "r" nil ;; reserved for visual-regexp
    ;; "R" nil ;; reserved for visual-regexp
    "s" 'meow-change
    ;;"S" nil ;; reserved for skparens
    "t" 'meow-till
    "T T" 'meow-swap-grab
    "T w" 'transpose-words
    "T x" 'transpose-sexps
    "T c" 'transpose-chars
    "u" 'undo
    "U" 'undo-redo
    ;;"v" nil ;; reserved for consult
    "V" 'multi-occur
    "w" 'meow-mark-word
    "W" 'meow-mark-symbol
    "x" 'meow-delete
    "X" 'meow-backward-delete
    "y" 'meow-save
    "Y" 'meow-sync-grab
    "z" 'meow-pop-selection
    ;;"Z" nil
    "<escape>" 'meow-cancel-selection)

  ;; meow behaves weridly without these definitions
  ;; see variable-help for details
  (setq meow--kbd-forward-char "C-x 9 f")
  (setq meow--kbd-backward-char "C-x 9 b")
  (setq meow--kbd-yank "C-x 9 y")

  (general-def
    "C-x 9 f" 'forward-char
    "C-x 9 b" 'backward-char
    "C-x 9 y" 'yank)

  (meow-global-mode 1))
