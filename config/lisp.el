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
