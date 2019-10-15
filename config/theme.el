;; ----- Theme ----- ;;

(put 'narrow-to-region 'disabled nil)

;; neotree
(use-package neotree
    :custom
    (neo-theme 'nerd2))

(setq-default neo-show-hidden-files t)
(setq neo-window-fixed-size nil)

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

(add-hook 'neotree-mode-hook
    (lambda ()
        (with-current-buffer " *NeoTree*"
            (setq-local linum-mode nil))))

;; doom themes
(use-package doom-themes
    :custom
    (doom-themes-enable-italic t)
    (doom-themes-enable-bold t)
    :custom-face
    (doom-modeline-bar ((t (:background "#6272a4"))))
    :config
    (load-theme 'tango-dark t)
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
    (column-number-mode 0))

;; font
(set-fontset-font t 'japanese-jisx0208 "TakaoPGothic")
(add-to-list 'face-font-rescale-alist '(".*Takao P.*" . 0.85))
