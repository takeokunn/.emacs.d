;; ----- Package ----- ;;

(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; auto-complete
(use-package auto-complete)
(use-package auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)

;; all-the-icons
(use-package all-the-icons)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

;; editorconfig
(use-package editorconfig
    :ensure t
    :config
    (editorconfig-mode 1))

;; emms
(use-package emms-setup)
(use-package emms-i18n)
(emms-standard)
(emms-default-players)
(setq emms-repeat-playlist t)
(setq emms-player-list '(emms-player-mplayer))
(setq emms-source-file-default-directory "~/emacs/emms/")

;; multi-term
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

;; ace-window
(use-package ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; company
(use-package company)
(global-company-mode)

;; dump jump mode
(use-package dumb-jump)
(setq dumb-jump-mode t)
(setq dumb-jump-selector 'ivy)
