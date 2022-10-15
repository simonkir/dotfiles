;;; -*- lexical-binding: t; -*-



(use-package meow
  :demand t
  :config

  ; general settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq meow-use-cursor-position-hack     t)
  (setq meow-expand-hint-remove-delay     2)
  (setq meow-display-thing-help           nil)
  (setq meow-keypad-self-insert-undefined nil)
  (setq meow-keypad-ctrl-meta-prefix      ?M)

  (setq meow-mode-state-list '((vterm-mode . insert)))
  (setq meow-expand-exclude-mode-list nil)



  ; meow-thing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;;(meow-thing-register 'latex-align  '(pair ("&") ("&"))                  '(pair ("&") ("&")))
  (meow-thing-register 'quote-gqq    '(pair ("„") ("“"))                  '(pair ("„") ("“")))
  (meow-thing-register 'quote-gq     '(pair ("‚") ("‘"))                  '(pair ("‚") ("‘")))
  (meow-thing-register 'quote-eqq    '(pair ("“") ("”"))                  '(pair ("“") ("”")))
  (meow-thing-register 'quote-eq     '(pair ("‘") ("’"))                  '(pair ("‘") ("’")))
  (meow-thing-register 'latex-round  '(pair ("\\left(") ("\\right)"))     '(pair ("\\left(") ("\\right)")))
  (meow-thing-register 'latex-square '(pair ("\\left[") ("\\right]"))     '(pair ("\\left[") ("\\right]")))
  (meow-thing-register 'latex-curly  '(pair ("\\left\\{") ("\\right\\}")) '(pair ("\\left\\{") ("\\right\\}")))

  (setq meow-char-thing-table
        '((?\( . round)
          (?\) . round)
          (?\[ . square)
          (?\] . square)
          (?{ . curly)
          (?} . curly)
          ;;(?& . latex-align)
          (?r . latex-round)
          (?s . latex-square)
          (?c . latex-curly)
          (?„ . quote-gqq)
          (?‚ . quote-gq)
          (?\“ . quote-eqq)
          (?\‘ . quote-eq)
          (?\" . string)
          (?b . buffer)
          (?p . paragraph)
          (?l . line)))



  ; keybinds ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun sk:meow-digit-argument-or-eval ()
    "when there is a region, act like eval, otherwise use digit-argument"
    (interactive)
    (let ((digit (- last-command-event ?0)))
      (if (or (< digit 0) (> digit 9))
          (message "digit not in range (digit = %s)" digit)
        (if meow--selection
            (meow-expand digit)
          (call-interactively 'meow-digit-argument)))))



  (bind-keys :map meow-motion-state-keymap
    ("j" . meow-next)
    ("k" . meow-prev))

  ;; TODO maybe remove? purpose of this doesnt seem clear
  ;;(bind-keys :map mode-specific-map
  ;;  ;; SPC j/k will run the original command in MOTION state.
  ;;  ("j" . "H-j")
  ;;  ("k" . "H-k"))

  (bind-keys :map meow-normal-state-keymap
    ("0" . sk:meow-digit-argument-or-eval)
    ("9" . sk:meow-digit-argument-or-eval)
    ("8" . sk:meow-digit-argument-or-eval)
    ("7" . sk:meow-digit-argument-or-eval)
    ("6" . sk:meow-digit-argument-or-eval)
    ("5" . sk:meow-digit-argument-or-eval)
    ("4" . sk:meow-digit-argument-or-eval)
    ("3" . sk:meow-digit-argument-or-eval)
    ("2" . sk:meow-digit-argument-or-eval)
    ("1" . sk:meow-digit-argument-or-eval)
    ("=" . indent-region)
    ("-" . negative-argument)
    (";" . meow-reverse)                  ;; new binding
    ("'" . repeat)
    ("," . meow-inner-of-thing)
    ("." . meow-bounds-of-thing)
    ("<" . meow-beginning-of-thing)
    (">" . meow-end-of-thing)
    ("a" . meow-append)
    ("A" . meow-open-below)
    ("b" . meow-back-word)
    ("B" . meow-back-symbol)
    ("c" . meow-join)
    ("d" . meow-kill)
    ("e" . meow-next-word)
    ("E" . meow-next-symbol)
    ("f" . meow-find)
    ;;("g" . meow-cancel-selection)
    ("G" . meow-grab)
    ("h" . meow-left)
    ("H" . meow-left-expand)
    ("i" . meow-insert)
    ("I" . meow-open-above)
    ("j" . meow-next)
    ("J" . meow-next-expand)
    ("k" . meow-prev)
    ("K" . meow-prev-expand)
    ("l" . meow-right)
    ("L" . meow-right-expand)
    ("m" . meow-line)
    ("M" . meow-goto-line)
    ("n" . meow-search)
    ("o" . meow-block)
    ("O" . meow-to-block)
    ("p" . meow-yank)
    ;;("q" . meow-quit)
    ("Q" . meow-goto-line)
    ("r" . meow-replace)
    ("R" . meow-swap-grab)
    ("s" . meow-change)
    ;;("S" . sk:meow-surround)           ;; todo surround function
    ("t" . meow-till)
    ("u" . meow-undo)
    ("U" . meow-undo-in-selection)
    ("v" . meow-visit)                   ;; evtl rebind to / to free v bind
    ("w" . meow-mark-word)
    ("W" . meow-mark-symbol)
    ("x" . meow-delete)
    ("X" . meow-backward-delete)
    ("y" . meow-save)
    ("Y" . meow-sync-grab)
    ("z" . meow-pop-selection)
    ("<escape>" . meow-cancel-selection))
  
  (meow-global-mode 1))
