;; ----- keybind ----- ;;

(defun beginning-of-line-or-intendation ()
    "move to beginning of line, or indentation"
    (interactive)
    (if (bolp)
        (back-to-indentation)
        (beginning-of-line)))

(defun back-other-window ()
  (interactive)
  (other-window -1))

(progn
    (bind-key "C-a" 'beginning-of-line-or-intendation)
    (bind-key "C-z" 'undo)
    (bind-key "C-h" 'delete-backward-char)
    (bind-key "C-?" 'help-command)
    (bind-key "C-m" 'set-mark-command)
    (bind-key "C-q" 'neotree-toggle)
    (bind-key "C-x j" 'open-junk-file)
    (bind-key "C-c c" 'org-capture)
    (bind-key "C-c a" 'org-agenda)
    (bind-key "C-x C-o" 'back-other-window)
    (bind-key "C-S-c C-S-c" 'mc/edit-lines)
    (bind-key "C-M-c" 'mc/edit-lines)
    (bind-key "C-M-r" 'mc/mark-all-in-region)
    (bind-key "C-x C-r" 'recentf-open-files))

(define-key isearch-mode-map "\C-h" 'isearch-delete-char)
