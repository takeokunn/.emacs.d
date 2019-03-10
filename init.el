;; ----- initialize ------ ;;

(if (eq system-type 'darwin)
    (require 'cask)
    (require 'cask "~/.cask/cask.el"))

(cask-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

(load "~/.emacs.d/config/base.el")
(load "~/.emacs.d/config/package.el")
(load "~/.emacs.d/config/lisp.el")
(load "~/.emacs.d/config/mode.el")
(load "~/.emacs.d/config/keybind.el")

(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background "#6272a4")))))
