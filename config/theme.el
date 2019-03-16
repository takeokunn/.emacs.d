;; ----- base ----- ;;

(load-theme 'sanityinc-tomorrow-night t)

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
