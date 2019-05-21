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
    (bind-key "C-x o" 'ace-window)
    (bind-key "C-x C-o" 'ace-window)
    (bind-key "C-x m" 'magit-status)
    (bind-key "C-c l" 'magit-blame))

;; for term
(define-key term-raw-map (kbd "C-h") 'term-send-backspace)
(define-key term-raw-map (kbd "C-p") 'term-send-up)
(define-key term-raw-map (kbd "C-n") 'term-send-down)
(define-key term-raw-map (kbd "C-f") 'term-send-forward-word)
(define-key term-raw-map (kbd "C-b") 'term-send-backward-word)

;; for emmet-mode
(define-key emmet-mode-keymap (kbd "C-j") nil)
(define-key emmet-mode-keymap (kbd "C-x i") 'emmet-expand-line)

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

;; for lsp
(defun lsp-mode-init ()
    (lsp)
    (global-set-key (kbd "M-*") 'xref-pop-marker-stack)
    (global-set-key (kbd "M-.") 'xref-find-definitions)
    (global-set-key (kbd "M-/") 'xref-find-references))

(defun ladicle/toggle-lsp-ui-doc ()
    (interactive)
    (if lsp-ui-doc-mode
        (progn
            (lsp-ui-doc-mode -1)
            (lsp-ui-doc--hide-frame))
        (lsp-ui-doc-mode 1)))

(define-key lsp-mode-map (kbd "C-c r") 'lsp-rename)
(define-key lsp-mode-map (kbd "C-c C-r") 'lsp-ui-peek-find-references)
(define-key lsp-mode-map (kbd "C-c C-j") 'lsp-ui-peek-find-definitions)
(define-key lsp-mode-map (kbd "C-c i") 'lsp-ui-peek-find-implementation)
(define-key lsp-mode-map (kbd "C-c m") 'lsp-ui-menu)
(define-key lsp-mode-map (kbd "C-c s") 'lsp-ui-sideline-mode)
(define-key lsp-mode-map (kbd "C-c d") 'ladicle/toggle-lsp-ui-doc)

;; markdown
(define-key markdown-mode-map (kbd "C-j") nil)
(define-key markdown-mode-map (kbd "C-m") nil)
