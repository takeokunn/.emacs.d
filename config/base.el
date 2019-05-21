;; ----- Base ----- ;;

;; initial view
(setq inhibit-startup-message t)

;; white space
(setq-default show-trailing-whitespace t)

;; editor bar
(menu-bar-mode -1)
(tool-bar-mode -1)
(global-linum-mode t)

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
