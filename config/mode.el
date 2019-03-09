;; ----- Mode ----- ;;

;; lisp
(add-to-list 'auto-mode-alist '("Cask" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.lemrc?$" . lisp-mode))

;; web
(use-package web-mode)
(add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb?$" . web-mode))
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

;; ruby
(add-hook 'ruby-mode-hook 'flycheck-mode)
(add-to-list 'auto-mode-alist '("Schemafile" . ruby-mode))

;; typescript
(autoload 'typescript-mode "typescript-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))

;; slim
(autoload 'slim-mode "slim-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.slim$" . slim-mode))

;; coffee
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

;; nginx
(autoload 'nginx-mode "nginx-mode" nil t)
(add-to-list 'auto-mode-alist '("/nginx/sites-\\(?:available\\|enabled\\)/" . nginx-mode))

;; ssh-config
(autoload 'ssh-config-mode "ssh-config-mode" nil t)
(add-to-list 'auto-mode-alist '("/path-to-your-ssh/config\\'" . ssh-config-mode))

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

;; nyan mode
(use-package nyan-mode)
(nyan-mode)
(nyan-start-animation)

;; dump jump mode
(use-package dumb-jump)
(setq dumb-jump-mode t)
(setq dumb-jump-selector 'ivy)
