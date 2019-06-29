;; ----- php ----- ;;

;; php-mode
(when (file-directory-p "~/.ghq/github.com/takeokunn/php-mode/")
    (add-to-list 'load-path (expand-file-name "~/.ghq/github.com/takeokunn/php-mode/"))
    (use-package "php-mode"))
(autoload 'php-mode "php-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

;; psysh.el
(when (file-directory-p "~/.ghq/github.com/takeokunn/psysh.el/")
    (add-to-list 'load-path (expand-file-name "~/.ghq/github.com/takeokunn/psysh.el/")))
