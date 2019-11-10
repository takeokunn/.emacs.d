;; ----- Org ----- ;;

(setq org-use-speed-commands t)
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
