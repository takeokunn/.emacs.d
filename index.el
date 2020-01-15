(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; -*- lexical-binding: nil -*-

;; initial view
(setq inhibit-startup-message t)

;; whitespace
(setq-default show-trailing-whitespace t)

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

;; error level
(setq display-warning-minimum-level :error)

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

(setq org-use-speed-commands t)
(setq org-agenda-todo-ignore-with-date t)
(setq org-directory "~/emacs/org")
(setq org-agenda-files '("~/emacs/org/todo.org"))
(setq org-capture-templates
      '(("t" "New TODO" entry
         (file+headline "~/emacs/org/todo.org" "予定")
         "* TODO %?\n\n")
        ("m" "Memo" entry
         (file+headline "~/emacs/org/memo.org" "メモ")
         "* %U%?\n%i\n%a")))
(setq org-agenda-custom-commands
      '(("a" "Agenda and TODO"
         ((agenda "")
          (alltodo "")))))
(put 'set-goal-column 'disabled nil)

;; ----- Theme ----- ;;

(put 'narrow-to-region 'disabled nil)

;; neotree
(use-package neotree
  :custom
  (neo-theme 'nerd2))

(setq-default neo-show-hidden-files t)
(setq neo-window-fixed-size nil)

(defun neo-buffer--insert-fold-symbol (name &optional file-name)
  "Custom overriding function for the fold symbol.
    `NAME' decides what fold icon to use, while `FILE-NAME' decides
    what file icon to use."
  (or (and (equal name 'open)  (insert (all-the-icons-icon-for-dir file-name "down")))
      (and (equal name 'close) (insert (all-the-icons-icon-for-dir file-name "right")))
      (and (equal name 'leaf)  (insert (format "\t\t\t%s\t" (all-the-icons-icon-for-file file-name))))))

(defun neo-buffer--insert-dir-entry (node depth expanded)
  (let ((node-short-name (neo-path--file-short-name node)))
    (insert-char ?\s (* (- depth 1) 2)) ; indent
    (when (memq 'char neo-vc-integration)
      (insert-char ?\s 2))
    (neo-buffer--insert-fold-symbol
     (if expanded 'open 'close) node)
    (insert-button (concat node-short-name "/")
                   'follow-link t
                   'face neo-dir-link-face
                   'neo-full-path node
                   'keymap neotree-dir-button-keymap)
    (neo-buffer--node-list-set nil node)
    (neo-buffer--newline-and-begin)))

(defun neo-buffer--insert-file-entry (node depth)
  (let ((node-short-name (neo-path--file-short-name node))
        (vc (when neo-vc-integration (neo-vc-for-node node))))
    (insert-char ?\s (* (- depth 1) 2)) ; indent
    (when (memq 'char neo-vc-integration)
      (insert-char (car vc))
      (insert-char ?\s))
    (neo-buffer--insert-fold-symbol 'leaf node-short-name)
    (insert-button node-short-name
                   'follow-link t
                   'face (if (memq 'face neo-vc-integration)
                             (cdr vc)
                           neo-file-link-face)
                   'neo-full-path node
                   'keymap neotree-file-button-keymap)
    (neo-buffer--node-list-set nil node)
    (neo-buffer--newline-and-begin)))

(add-hook 'neotree-mode-hook
          (lambda ()
            (with-current-buffer " *NeoTree*"
              (setq-local linum-mode nil))))

;; doom themes
(use-package doom-themes
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :custom-face
  (doom-modeline-bar ((t (:background "#6272a4"))))
  :config
  (load-theme 'tango-dark t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

;; doom modeline
(use-package doom-modeline
  :custom
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  (doom-modeline-icon t)
  (doom-modeline-major-mode-icon nil)
  (doom-modeline-minor-modes nil)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (line-number-mode 0)
  (column-number-mode 0))

;; font
(set-fontset-font t 'japanese-jisx0208 "TakaoPGothic")
(add-to-list 'face-font-rescale-alist '(".*Takao P.*" . 0.85))

;; ----- Plugin ----- ;;

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; hl-line
(use-package hl-line)
(set-face-background 'hl-line "#444642")
(set-face-attribute 'hl-line nil :inherit nil)
(defvar global-hl-line-timer-exclude-modes '(todotxt-mode))
(defun global-hl-line-timer-function ()
  (unless (memq major-mode global-hl-line-timer-exclude-modes)
    (global-hl-line-unhighlight-all)
    (let ((global-hl-line-mode t))
      (global-hl-line-highlight))))
(setq global-hl-line-timer
    (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))

;; TODO: hl-todo
(setq hl-todo-keyword-faces
      '(("HOLD" . "#d0bf8f")
        ("TODO" . "#cc9393")
        ("NEXT" . "#dca3a3")
        ("THEM" . "#dc8cc3")
        ("PROG" . "#7cb8bb")
        ("OKAY" . "#7cb8bb")
        ("DONT" . "#5f7f5f")
        ("FAIL" . "#8c5353")
        ("DONE" . "#afd8af")
        ("FIXME" . "#cc9393")
        ("???"   . "#cc9393")))
(setq hl-todo-activate-in-modes '(prog-mode ruby-mode enh-ruby-mode))
(global-hl-todo-mode 1)

;; all-the-icons
(use-package all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; editorconfig
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; emms
(use-package emms-setup)
(use-package emms-i18n)
(emms-standard)
(emms-default-players)
(setq emms-repeat-playlist t)
(setq emms-player-list '(emms-player-mplayer))
(setq emms-source-file-default-directory "~/emacs/emms/")

;; multi-term
(use-package multi-term)
(setq multi-term-program shell-file-name)

;; open junk file
(use-package open-junk-file)
(setq open-junk-file-format "~/.emacs.d/.junk/%Y-%m%d-%H%M%S.")

;; multiple-cursors
(use-package smartrep)
(use-package multiple-cursors)

;; yasnippet
(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode)

(use-package yasnippet-snippets)
(yas-global-mode 1)

;; counsel
(use-package counsel)
(setq ivy-use-virtual-buffers t)
(setq counsel-ag-base-command "ag --nocolor --nogroup -u %s")
(ivy-mode 1)
(counsel-mode 1)

;; all-the-icons-ivy
(use-package all-the-icons-ivy
  :ensure t
  :config
  (all-the-icons-ivy-setup))

;; recentf
(use-package recentf)
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-exclude '(".recentf"))
(recentf-mode 1)

;; magit
(use-package magit)

;; ivy-rich
(use-package ivy-rich)
(ivy-rich-mode 1)

;; ace-window
(use-package ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; dump jump mode
(use-package dumb-jump)
(setq dumb-jump-mode t)
(setq dumb-jump-selector 'ivy)

;; rg
(use-package rg
    :hook ((rg-mode . wgrep-rg-setup)))
(rg-enable-default-bindings)

;; goto-addr
(use-package goto-addr
    :hook ((prog-mode . goto-address-prog-mode)
              (text-mode . goto-address-mode)))

;; swoop
(use-package swoop)
(setq swoop-minibuffer-input-dilay 0.4)

;; whitespace
(use-package whitespace)
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-tab "#adff2f")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#7cfc00")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(global-whitespace-mode 1)

;; dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; company
(use-package company)
(use-package company-glsl)
(global-company-mode)
(add-to-list 'company-backends 'company-glsl)

;; git-gutter
(use-package git-gutter-fringe)
(global-git-gutter-mode +1)

;; smooth-scroll
(use-package smooth-scroll)
(smooth-scroll-mode t)

;; exec-path-from-shell
(use-package exec-path-from-shell)
(exec-path-from-shell-copy-envs '("PATH" "GEM_HOME"))

;; ghc
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

;; hindent
(add-hook 'haskell-mode-hook #'hindent-mode)
(setq hindent-style "johan-tibell")

;; typescript
(defun my/setup-tide-mode ()
  (interactive)
  (tide-setup)
  (tide-hl-identifier-mode +1))
(add-hook 'typescript-mode-hook #'my/setup-tide-mode)

;; js2-mode
(setq js2-skip-preprocessor-directives t)

;; js2-refactor
(use-package js2-refactor)
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-hook 'typescript-mode-hook #'js2-refactor-mode)

;; ivy-ghq
(use-package ivy-ghq
  :commands (ivy-ghq-open)
  :bind
  ("M-o" . ivy-ghq-open-and-fzf)
  :custom
  (ivy-ghq-short-list t)
  :preface
  (defun ivy-ghq-open-and-fzf ()
    (interactive)
    (ivy-ghq-open)
    (counsel-fzf)))

;; vterm
(use-package vterm)
(add-hook 'vterm-mode-hook #'(lambda ()
                               (setq show-trailing-whitespace nil)))

;; ----- Common Lisp ----- ;;

;; slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

;; ac-slime
(use-package ac-slime)
(add-hook 'slime-mode-hook 'set-up-slime-ac)
(add-hook 'slime-repl-mode-hook 'set-up-slime-ac)

;; hyperspec
(setq common-lisp-hyperspec-root "~/quicklisp/HyperSpec/")

(defun common-lisp-hyperspec (symbol-name)
    (interactive (list (common-lisp-hyperspec-read-symbol-name)))
    (let ((name (common-lisp-hyperspec--strip-cl-package
                    (downcase symbol-name))))
        (cl-maplist (lambda (entry)
                        (eww-open-file (concat common-lisp-hyperspec-root "Body/"
                                           (car entry)))
                        (when (cdr entry)
                            (sleep-for 1.5)))
            (or (common-lisp-hyperspec--find name)
                (error "The symbol `%s' is not defined in Common Lisp"
                    symbol-name)))))

(defun common-lisp-hyperspec-lookup-reader-macro (macro)
  (interactive
   (list
    (let ((completion-ignore-case t))
      (completing-read "Look up reader-macro: "
                       common-lisp-hyperspec--reader-macros nil t
                       (common-lisp-hyperspec-reader-macro-at-point)))))
  (eww-open-file
   (concat common-lisp-hyperspec-root "Body/"
           (gethash macro common-lisp-hyperspec--reader-macros))))

(defun common-lisp-hyperspec-format (character-name)
  (interactive (list (common-lisp-hyperspec--read-format-character)))
  (cl-maplist (lambda (entry)
                (eww-open-file (common-lisp-hyperspec-section (car entry))))
              (or (gethash character-name
                           common-lisp-hyperspec--format-characters)
                  (error "The symbol `%s' is not defined in Common Lisp"
                         character-name))))

(defadvice common-lisp-hyperspec (around common-lisp-hyperspec-around activate)
  (let ((buf (current-buffer)))
    ad-do-it
    (switch-to-buffer buf)
    (pop-to-buffer "*eww*")))

(defadvice common-lisp-hyperspec-lookup-reader-macro (around common-lisp-hyperspec-lookup-reader-macro-around activate)
  (let ((buf (current-buffer)))
    ad-do-it
    (switch-to-buffer buf)
    (pop-to-buffer "*eww*")))

(defadvice common-lisp-hyperspec-format (around common-lisp-hyperspec-format activate)
  (let ((buf (current-buffer)))
    ad-do-it
    (switch-to-buffer buf)
    (pop-to-buffer "*eww*")))
(dolist (hook '(emacs-lisp-mode-hook
                lisp-interaction-mode-hook
                ielm-mode-hook))
  (add-hook hook 'elisp-slime-nav-mode))

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

;; ----- Lsp ----- ;;

;;;;;;;;;;;;;;
;; lsp-mode ;;
;;;;;;;;;;;;;;
(use-package lsp-mode)
(use-package lsp-java)
(use-package lsp-haskell)

;; config
(setq lsp-print-io nil)
(setq lsp-trace nil)
(setq lsp-print-performance nil)
(setq lsp-auto-guess-root t)
(setq lsp-document-sync-method 'incremental)
(setq lsp-response-timeout 5)
(setq lsp-ui-sideline-enable nil)
(setq lsp-prefer-flymake nil)

;; path
(add-to-list 'exec-path "~/.npm-global/bin" t)

;; hook
(dolist (hook '(go-mode-hook
                js2-mode-hook
                web-mode-hook
                css-mode-hook
                scss-mode-hook
                ruby-mode-hook
                haskell-mode-hook
                typescript-mode-hook
                java-mode-hook
                vue-mode-hook
                sh-mode-hook
                shell-mode-hook
                php-mode-hook
                python-mode-hook))
  (add-hook hook #'lsp))
(add-hook 'lsp-mode-hook 'flycheck-mode)

;;;;;;;;;;;;;;
;;  lsp-ui  ;;
;;;;;;;;;;;;;;
(use-package lsp-ui)

;; config lsp-ui-doc
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-max-height 15)

;; config lsp-ui-sideline
(setq lsp-ui-sideline-enable nil)

;; config lsp-ui-imenu
(setq lsp-ui-imenu-enable nil)

;; hook
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;;;;;;;;;;;;;;;;;
;; company-lsp ;;
;;;;;;;;;;;;;;;;;
(use-package company-lsp)

;; push
(push 'company-lsp company-backends)

;;;;;;;;;;;;;;;;;
;;  dap-mode   ;;
;;;;;;;;;;;;;;;;;
(use-package dap-php)
(use-package dap-node)
(use-package dap-ruby)
(use-package dap-chrome)

;; config
(dap-mode 1)
(dap-ui-mode 1)

;; ----- Mode ----- ;;

;; lisp
(add-to-list 'auto-mode-alist '("Cask" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.lemrc?$" . lisp-mode))

;; web
(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb?$" . web-mode))
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

;; dhall
(autoload 'dhall-mode "dhall-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.dhall$" . dhall-mode))

;; javascript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook #'js2-refactor-mode)

;; ruby
(add-to-list 'auto-mode-alist '("Schemafile" . ruby-mode))
(add-hook 'ruby-mode-hook 'ruby-refactor-mode-launch)

;; typescript
(autoload 'typescript-mode "typescript-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'typescript-mode-hook #'js2-refactor-mode)
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (my/setup-tide-mode))))

;; slim
(autoload 'slim-mode "slim-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.slim$" . slim-mode))

;; coffee
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

;; scala
(autoload 'scala-mode "scala-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.scala$" . scala-mode))

;; nginx
(autoload 'nginx-mode "nginx-mode" nil t)
(add-to-list 'auto-mode-alist '("/nginx/sites-\\(?:available\\|enabled\\)/" . nginx-mode))

;; ssh-config
(autoload 'ssh-config-mode "ssh-config-mode" nil t)
(add-to-list 'auto-mode-alist '("/path-to-your-ssh/config\\'" . ssh-config-mode))

;; php
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;; clojure
(autoload 'clojure-mode "clojure-mode" nil t)
(autoload 'clojure-mode "clojurescript-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs$" . clojurescript-mode))

;; vue
(autoload 'vue-mode "vue-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vue$" . vue-mode))

;; glsl
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vsh$" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.fsh$" . glsl-mode))

;; emmet
(use-package emmet-mode)
(autoload 'emmet-mode "emmet-mode" nil t)
(add-hook 'web-mode-hook 'emmet-mode)

;; nyan mode
(use-package nyan-mode)
(nyan-mode)
(nyan-start-animation)
(setq nyan-wavy-trail t)

;; elc
(add-to-list 'auto-mode-alist '("\\.elc\\'" . fundamental-mode))

;; elisp
(add-hook 'emacs-lisp-mode-hook #'nameless-mode)

;; haskell
(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cable$" . haskell-cabal-mode))

;; gradle
(autoload 'gradle-mode "gradle-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.gradle$" . java-mode))

;; cmake
(autoload 'cmake-mode "cmake-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.cmake$" . cmake-mode))

;; toml
(autoload 'toml-mode "toml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.toml$" . toml-mode))

;; php
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;; gitignore
(autoload 'gitignore-mode "gitignore-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.dockerignore$" . gitignore-mode))


;; clojure
(autoload 'clojure-mode "clojure-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; plantuml
(autoload 'plantuml-mode "plantuml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.pu$" . plantuml-mode))

;; processing
(autoload 'processing-mode "processing-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.pde$" . processing-mode))
(setq processing-location "/opt/processing/processing-java")
(setq processing-output-dir "/tmp")

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
  (bind-key "M-g" 'google-this)
  (bind-key "C-x C-k" nil))

;; for refactor
(define-key prog-mode-map (kbd "M-RET") 'emr-show-refactor-menu)

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
(define-key lsp-mode-map (kbd "C-c s") 'lsp-ui-sideline-mode)
(define-key lsp-mode-map (kbd "M-.") #'lsp-ui-peek-find-definitions)
(define-key lsp-mode-map (kbd "M-?") 'lsp-ui-peek-find-implementation)

;; for dap-mode
(define-key lsp-mode-map (kbd "C-c d") 'dap-breakpoint-toggle)

;; for markdown
(define-key markdown-mode-map (kbd "C-j") nil)
(define-key markdown-mode-map (kbd "C-m") nil)

;; for swoop
(defun my/swoop-from-isearch ()
  (interactive)
  (let* ((symbol (thing-at-point 'symbol 'no-properties)))
    (swoop symbol)))
(define-key ivy-mode-map (kbd "C-o") 'my/swoop-from-isearch)

;; for common lisp
(define-key lisp-mode-map (kbd "C-c h") 'hyperspec-lookup)

;; for haskell
(define-key haskell-indentation-mode-map (kbd "C-m") nil)

;; for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map (kbd "C-m") nil)))

;; for js2-mode
(js2r-add-keybindings-with-prefix "C-c C-m")

;; vterm
(define-key vterm-mode-map [mouse-1] nil)
(define-key vterm-mode-map [mouse-2] nil)
(define-key vterm-mode-map [mouse-3] nil)
(define-key vterm-mode-map [mouse-4] nil)
(define-key vterm-mode-map [mouse-5] nil)
(define-key vterm-mode-map [mouse-5] nil)
