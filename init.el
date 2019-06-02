(require 'cask "~/.cask/cask.el")

(cask-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

(load "~/.emacs.d/config/base.el")
(load "~/.emacs.d/config/package.el")
(load "~/.emacs.d/config/theme.el")
(load "~/.emacs.d/config/lisp.el")
(load "~/.emacs.d/config/mode.el")
(load "~/.emacs.d/config/lsp.el")
(load "~/.emacs.d/config/org.el")
(load "~/.emacs.d/config/keybind.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(neo-theme (quote nerd2))
    '(package-selected-packages
         (quote
             (nameless git-gutter yasnippet-snippets yaml-mode web-mode vimrc-mode use-package typescript-mode terraform-mode ssh-config-mode smartrep smartparens slim-mode scala-mode rg rainbow-delimiters php-mode paredit open-junk-file nyan-mode nginx-mode neotree multiple-cursors multi-term magit lsp-ui json-mode js2-mode ivy-rich go-mode fish-mode find-file-in-project emms emmet-mode elisp-slime-nav editorconfig dumb-jump doom-themes doom-modeline dockerfile-mode dhall-mode dap-mode counsel company-lsp coffee-mode clojure-mode cask all-the-icons-dired ace-window ac-slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4")))))
