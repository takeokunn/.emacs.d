;; ----- key bind ----- ;;

(keyboard-translate ?\C-h ?\C-?)

(defun my/beginning-of-intendation ()
    "move to beginning of line, or indentation"
    (interactive)
    (back-to-indentation))

(defun my/ido-recentf ()
    (interactive)
    (find-file (ido-completing-read "Find recent file: " recentf-list)))

(defun my/counsel-ag ()
    (interactive)
    (let ((symbol (thing-at-point 'symbol 'no-properties)))
        (counsel-ag symbol)))

(progn
    (bind-key "C-a" 'my/beginning-of-intendation)
    (bind-key "C-z" 'undo)
    (bind-key "C-h" 'delete-backward-char)
    (bind-key "C-?" 'help-command)
    (bind-key "C-m" 'set-mark-command)
    (bind-key "C-q" 'neotree-toggle)
    (bind-key "C-x j" 'open-junk-file)
    (bind-key "C-c i" 'find-function)
    (bind-key "C-c c" 'org-capture)
    (bind-key "C-c a" 'org-agenda)
    (bind-key "C-x o" 'ace-window)
    (bind-key "C-x C-o" 'ace-window)
    (bind-key "C-x m" 'magit-status)
    (bind-key "C-c l" 'magit-blame)
    (bind-key "C-c j" 'counsel-git)
    (bind-key "C-c k" 'my/counsel-ag)
    (bind-key "C-x C-r" 'counsel-recentf)
    (bind-key "C-x C-f" 'counsel-find-file)
    (bind-key "M-x" 'counsel-M-x)
    (bind-key "C-x C-k" nil))

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

;; for lsp-mode
(define-key lsp-mode-map (kbd "C-c C-r") 'lsp-ui-peek-find-references)
(define-key lsp-mode-map (kbd "C-c C-j") 'lsp-ui-peek-find-definitions)
(define-key lsp-mode-map (kbd "C-c i") 'lsp-ui-peek-find-implementation)
(define-key lsp-mode-map (kbd "C-c s") 'lsp-ui-sideline-mode)

;; for dap-mode
(define-key lsp-mode-map (kbd "C-c d") 'dap-breakpoint-toggle)

;; markdown
(define-key markdown-mode-map (kbd "C-j") nil)
(define-key markdown-mode-map (kbd "C-m") nil)

;; swoop
(define-key ivy-mode-map (kbd "C-o") 'swoop-from-isearch)

;; common lisp
(define-key lisp-mode-map (kbd "C-c h") 'hyperspec-lookup)
