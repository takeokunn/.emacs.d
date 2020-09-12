(load "~/.emacs.d/index")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-buffer-file-name-style 'truncate-with-project)
 '(doom-modeline-icon t)
 '(doom-modeline-major-mode-icon nil)
 '(doom-modeline-minor-modes nil)
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("org" . "https://orgmode.org/elpa/")))
 '(package-selected-packages
   '(git-gutter-fringe magit dap-mode lsp-ui yasnippet-snippets yasnippet slime-company company-lsp company-glsl company emr nyan-mode neotree hl-todo doom-themes doom-modeline all-the-icons-ivy all-the-icons cider nameless elisp-slime-nav rainbow-delimiters paredit web-mode vue-mode typescript-mode toml-mode terraform-mode ssh-config-mode slim-mode scala-mode rust-mode python-mode processing-mode plantuml-mode php-mode markdown-mode nginx-mode csv-mode lisp-mode json-mode js2-mode haskell-mode gradle-mode gitignore-mode fish-mode emmet-mode dockerfile-mode docker-compose-mode use-package leaf-convert leaf-keywords hydra ht general f el-get dash-functional blackout)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4"))) nil "Customized with leaf in doom-themes block"))
