;; ----- package ----- ;;

(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; transpose-frame
(use-package transpose-frame)

;; auto-complete
(use-package auto-complete)
(use-package auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)

;; all-the-icons
(use-package all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; neotree
(use-package neotree)
; (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq-default neo-show-hidden-files t)
(defun neo-buffer--insert-fold-symbol (name &optional file-name)
    "Custom overriding function for the fold symbol.
`NAME' decides what fold icon to use, while `FILE-NAME' decides
what file icon to use."
    (or (and (equal name 'open)  (insert (all-the-icons-icon-for-dir file-name "down")))
        (and (equal name 'close) (insert (all-the-icons-icon-for-dir file-name "right")))
        (and (equal name 'leaf)  (insert (format "\t\t\t%s\t" (all-the-icons-icon-for-file file-name))))))

(defun neo-buffer--insert-dir-entry (node depth expanded)
    (let ((node-short-name (neo-path--file-short-name node)))
        (insert-char ?\s (* (- depth 1) 2)) ; indent
        (when (memq 'char neo-vc-integration)
            (insert-char ?\s 2))
        (neo-buffer--insert-fold-symbol
            (if expanded 'open 'close) node)
        (insert-button (concat node-short-name "/")
            'follow-link t
            'face neo-dir-link-face
            'neo-full-path node
            'keymap neotree-dir-button-keymap)
        (neo-buffer--node-list-set nil node)
        (neo-buffer--newline-and-begin)))

(defun neo-buffer--insert-file-entry (node depth)
    (let ((node-short-name (neo-path--file-short-name node))
             (vc (when neo-vc-integration (neo-vc-for-node node))))
        (insert-char ?\s (* (- depth 1) 2)) ; indent
        (when (memq 'char neo-vc-integration)
            (insert-char (car vc))
            (insert-char ?\s))
        (neo-buffer--insert-fold-symbol 'leaf node-short-name)
        (insert-button node-short-name
            'follow-link t
            'face (if (memq 'face neo-vc-integration)
                      (cdr vc)
                      neo-file-link-face)
            'neo-full-path node
            'keymap neotree-file-button-keymap)
        (neo-buffer--node-list-set nil node)
        (neo-buffer--newline-and-begin)))

;; move-text
(use-package move-text)

;; smooth-scroll
(use-package smooth-scroll)

;; highlight-indentation
(use-package highlight-indentation)

;; editorconfig
(use-package editorconfig
    :ensure t
    :config
    (editorconfig-mode 1))

;; highlight-indentation
(use-package highlight-indentation)
(set-face-background 'highlight-indentation-face "#555555")
(set-face-background 'highlight-indentation-current-column-face "#555555")
(add-hook 'yaml-mode-hook 'highlight-indentation-mode)
(add-hook 'yaml-mode-hook 'highlight-indentation-current-column-mode)

;; flymake
(use-package flymake-yaml)
(add-hook 'yaml-mode-hook 'flymake-yaml-load)

;; emms
(use-package emms-setup)
(use-package emms-i18n)
(emms-standard)
(emms-default-players)
(setq emms-repeat-playlist t)
(setq emms-player-list '(emms-player-mplayer))
(setq emms-source-file-default-directory "~/emacs/emms/")

;; multi term
(use-package multi-term)
(setq multi-term-program shell-file-name)

;; open junk file
(use-package open-junk-file)
(setq open-junk-file-format "~/.emacs.d/.junk/%Y-%m%d-%H%M%S.")

;; multiple-cursors
(use-package smartrep)
(use-package multiple-cursors)

;; yasnippet
(use-package yasnippet
    :ensure t
    :diminish yas-minor-mode)

(use-package yasnippet-snippets)
(yas-global-mode 1)

;; counsel
(use-package counsel)
(ivy-mode 1)
(counsel-mode 1)

;; inf-ruby
(use-package inf-ruby)

;; find-file-in-project
(use-package find-file-in-project)

;; recentf
(use-package recentf)
(setq recentf-max-saved-items 2000)
(setq recentf-auto-cleanup 'never)
(setq recentf-save-file "~/.emacs.d/.recentf")
(setq recentf-exclude '(".recentf"))
(recentf-mode 1)

;; magit
(use-package magit)

;; ivy-rich
(use-package ivy-rich)
(ivy-rich-mode 1)

;; doom themes
(use-package doom-themes
    :custom
    (doom-themes-enable-italic t)
    (doom-themes-enable-bold t)
    :custom-face
    (doom-modeline-bar ((t (:background "#6272a4"))))
    :config
    (load-theme 'doom-tomorrow-night t)
    (doom-themes-neotree-config)
    (doom-themes-org-config))

;; doom modeline
(use-package doom-modeline
    :custom
    (doom-modeline-buffer-file-name-style 'truncate-with-project)
    (doom-modeline-icon t)
    (doom-modeline-major-mode-icon nil)
    (doom-modeline-minor-modes nil)
    :hook
    (after-init . doom-modeline-mode)
    :config
    (line-number-mode 0)
    (column-number-mode 0)
    (doom-modeline-def-modeline 'main
        '(bar workspace-number window-number evil-state god-state ryo-modal xah-fly-keys matches buffer-info remote-host buffer-position parrot selection-info)
        '(misc-info persp-name lsp github debug minor-modes input-method major-mode process vcs checker)))

;; ace-window
(use-package ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
