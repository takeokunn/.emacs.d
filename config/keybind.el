;; ----- keybind ----- ;;

(defun beginning-of-line-or-intendation ()
    "move to beginning of line, or indentation"
    (interactive)
    (if (bolp)
        (back-to-indentation)
        (beginning-of-line)))

(keyboard-translate ?\C-h ?\C-?)

(progn
    (bind-key "C-a" 'beginning-of-line-or-intendation)
    (bind-key "C-z" 'undo)
    (bind-key "C-h" 'delete-backward-char)
    (bind-key "C-?" 'help-command)
    (bind-key "C-m" 'set-mark-command)
    (bind-key "C-q" 'neotree-toggle)
    (bind-key "C-x j" 'open-junk-file)
    (bind-key "C-c c" 'org-capture)
    (bind-key "C-c a" 'org-agenda)
    (bind-key "C-S-c C-S-c" 'mc/edit-lines)
    (bind-key "C-M-c" 'mc/edit-lines)
    (bind-key "C-M-r" 'mc/mark-all-in-region)
    (bind-key "C-x C-r" 'recentf-open-files)
    (bind-key "C-x o" 'switch-window)
    (bind-key "C-x C-o" 'switch-window))

;; for multi term
(add-hook 'term-mode-hook
    '(lambda ()
         (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
         (define-key term-raw-map (kbd "C-p") 'term-send-up)
         (define-key term-raw-map (kbd "C-n") 'term-send-down)
         (define-key term-raw-map (kbd "C-f") 'term-send-forward-word)
         (define-key term-raw-map (kbd "C-b") 'term-send-backward-word)))

;; for multi-cursor
(global-unset-key "\C-t")
(smartrep-define-key global-map "C-t"
    '(("n" . 'mc/mark-next-like-this)
         ("p" . 'mc/mark-previous-like-this)
         ("m" . 'mc/mark-more-like-this-extended)
         ("u" . 'mc/unmark-next-like-this)
         ("U" . 'mc/unmark-previous-like-this)
         ("s" . 'mc/skip-to-next-like-this)
         ("S" . 'mc/skip-to-previous-like-this)
         ("*" . 'mc/mark-all-like-this)
         ("d" . 'mc/mark-all-like-this-dwim)
         ("i" . 'mc/insert-numbers)
         ("o" . 'mc/sort-regions)
         ("O" . 'mc/reverse-regions)))

;; yasnippet
(smartrep-define-key global-map "C-x"
    '(("C-i" . 'yas-insert-snippet)
         ("C-n" . 'yas-new-snippet)
         ("C-v" . 'yas-visit-snippet-file)
         ("C-l" . 'yas-describe-tables)
         ("C-g" . 'yas-reload-all)))
