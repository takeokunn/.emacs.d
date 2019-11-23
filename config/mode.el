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
