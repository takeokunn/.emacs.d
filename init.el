;; ----- initialize ------ ;;

(require 'cask)
(cask-initialize)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp"))

(load "~/.emacs.d/config/base.el")
(load "~/.emacs.d/config/package.el")
(load "~/.emacs.d/config/lisp.el")
(load "~/.emacs.d/config/mode.el")
(load "~/.emacs.d/config/keybind.el")
