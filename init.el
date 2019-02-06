;; ----- initialize ------ ;;

(require 'cask)
(cask-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

;; ----- theme ----- ;;

(load-theme 'tango-dark)
(set-cursor-color "#000000")

;; ----- config ------ ;;

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

;; ----- package ----- ;;

(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; transpose-frame
(use-package transpose-frame)

;; auto-complete
(use-package auto-complete)
(use-package auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)

;; drill-instructor
(use-package drill-instructor)
(setq drill-instructor-global t)

;; neotree
(use-package neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq-default neo-show-hidden-files t)

;; move-text
(use-package move-text)

;; smooth-scroll
(use-package smooth-scroll)

;; highlight-indentation
(use-package highlight-indentation)

;; editorconfig
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; highlight-indentation
(use-package highlight-indentation)
(set-face-background 'highlight-indentation-face "#555555")
(set-face-background 'highlight-indentation-current-column-face "#555555")
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)
(add-hook 'yaml-mode-hook 'highlight-indentation-current-column-mode)

;; flycheck
(use-package flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package flymake-yaml)
(add-hook 'yaml-mode-hook 'flymake-yaml-load)

;; emms
(use-package emms-setup)
(use-package emms-i18n)
(emms-standard)
(emms-default-players)
(setq emms-repeat-playlist t)
(setq emms-player-list '(emms-player-mplayer))
(setq emms-source-file-default-directory "~/emacs/emms/")

;; multi term
(use-package multi-term)
(setq multi-term-program shell-file-name)
(add-hook 'term-mode-hook
    '(lambda ()
         (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
         (define-key term-raw-map (kbd "C-p") 'term-send-up)
         (define-key term-raw-map (kbd "C-n") 'term-send-down)
         (define-key term-raw-map (kbd "C-f") 'term-send-forward-word)
         (define-key term-raw-map (kbd "C-b") 'term-send-backward-word)))

;; open junk file
(use-package open-junk-file)
(setq open-junk-file-format "~/emacs/junk/%Y-%m%d-%H%M%S.")

;; multiple-cursors
(use-package smartrep)
(use-package multiple-cursors)

(declare-function smartrep-define-key "smartrep")

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

;; phi-search
(use-package phi-search)

;; yasnippet
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :bind (:map yas-minor-mode-map
              ("C-x i i" . yas-insert-snippet)
              ("C-x i n" . yas-new-snippet)
              ("C-x i v" . yas-visit-snippet-file)
              ("C-x i l" . yas-describe-tables)
              ("C-x i g" . yas-reload-all)))
(use-package yasnippet-snippets)
(yas-global-mode 1)

;; ----- keybind ----- ;;

(defun beginning-of-line-or-intendation ()
    "move to beginning of line, or indentation"
    (interactive)
    (if (bolp)
        (back-to-indentation)
        (beginning-of-line)))

(defun back-other-window ()
  (interactive)
  (other-window -1))

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
    (bind-key "C-x C-o" 'back-other-window)
    (bind-key "C-S-c C-S-c" 'mc/edit-lines)
    (bind-key "C-M-c" 'mc/edit-lines)
    (bind-key "C-M-r" 'mc/mark-all-in-region)
    (bind-key "C-s" 'phi-search)
    (bind-key "C-r" 'phi-search-backward)
    (bind-key "M-/" 'comment-or-uncomment-region))

(define-key isearch-mode-map "\C-h" 'isearch-delete-char)

;; ----- Lisp ----- ;;

;; slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;; ac-slime
(use-package ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; paredit
(use-package paredit)
(autoload 'enable-paredit-mode "paredit" t)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook 'enable-paredit-mode)
(eval-after-load "paredit"
  #'(define-key paredit-mode-map (kbd "C-c f") 'paredit-forward-slurp-sexp))
(eval-after-load "paredit"
  #'(define-key paredit-mode-map (kbd "C-c b") 'paredit-forward-barf-sexp))

;; rainbow-dpelimiters
(use-package rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; ----- Mode ----- ;;

;; lisp
(add-to-list 'auto-mode-alist '("Cask" . lisp-mode))

;; web
(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-hook 'web-mode-hook 'web-mode-hook)
(setq web-mode-auto-close-style t)
(setq web-mode-tag-auto-close-style t)

;; go
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go$" . go-mode))

;; terraform
(autoload 'terraform-mode "terraform-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.tf$" . terraform-mode))

;; markdown
(autoload 'markdown-mode "markdown-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;; yaml
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

;; json
(autoload 'json-mode "json-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

;; dockerfile
(autoload 'dockerfile-mode "dockerfile-mode" nil t)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; fish
(autoload 'fish-mode "fish-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.fish$" . fish-mode))

;; php
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;; dhall
(autoload 'dhall-mode "dhall-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.dhall$" . dhall-mode))
(setq dhall-use-header-line nil)

;; javascript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; vimrc
(autoload 'vimrc-mode "vimrc-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode))

;; ruby
(add-to-list 'auto-mode-alist '("Schemafile" . ruby-mode))

;; org mode
(setq org-agenda-todo-ignore-with-date t)
(setq org-directory "~/emacs/org")
(setq org-agenda-files '("~/emacs/org/todo.org"))
(setq org-capture-templates
    '(("t" "New TODO" entry
          (file+headline "~/emacs/org/todo.org" "予定")
          "* TODO %?\n\n")
         ("m" "Memo" entry
             (file+headline "~/emacs/memo.org" "メモ")
             "* %U%?\n%i\n%a")))
(setq org-agenda-custom-commands
    '(("a" "Agenda and TODO"
          ((agenda "")
              (alltodo "")))))
(put 'set-goal-column 'disabled nil)
