;; ----- Base ----- ;;

;; initial view
(setq inhibit-startup-message t)

;; whitespace
(setq-default show-trailing-whitespace t)

(defun my/disable-trailing-mode-hook ()
    "Disable show tail whitespace."
    (setq show-trailing-whitespace nil))

(defvar my/disable-trailing-modes
    '(comint-mode
         eshell-mode
         eww-mode
         term-mode
         twittering-mode
         minibuffer-inactive-mode))
(mapc
    (lambda (mode)
        (add-hook (intern (concat (symbol-name mode) "-hook"))
            'my/disable-trailing-mode-hook))
    my/disable-trailing-modes)

;; editor bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-linum-mode t)
(toggle-scroll-bar -1)

;; auto generate file
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;; delete a line with C-k
(setq kill-whole-line t)

;; ignore ring bell
(setq ring-bell-function 'ignore)

;; highlight
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; tab
(setq-default tab-widtph 4 indent-tabs-mode nil)

;; pair
(electric-pair-mode 1)

;; window size
(setq window-min-height 10)

;; system time locale
(setq system-time-locale "C")

;; ruby encoding magic comment
(setq ruby-insert-encoding-magic-comment nil)
