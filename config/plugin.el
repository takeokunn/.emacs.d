;; ----- Plugin ----- ;;

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; hl-line
(use-package hl-line)
(set-face-background 'hl-line "#444642")
(set-face-attribute 'hl-line nil :inherit nil)
(defvar global-hl-line-timer-exclude-modes '(todotxt-mode))
(defun global-hl-line-timer-function ()
    (unless (memq major-mode global-hl-line-timer-exclude-modes)
        (global-hl-line-unhighlight-all)
        (let ((global-hl-line-mode t))
            (global-hl-line-highlight))))
(setq global-hl-line-timer
    (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))

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
(setq ivy-use-virtual-buffers t)
(setq counsel-ag-base-command "ag --nocolor --nogroup -u %s")
(ivy-mode 1)
(counsel-mode 1)

;; all-the-icons-ivy
(use-package all-the-icons-ivy
    :ensure t
    :config
    (all-the-icons-ivy-setup))

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

;; dump jump mode
(use-package dumb-jump)
(setq dumb-jump-mode t)
(setq dumb-jump-selector 'ivy)

;; rg
(use-package rg
    :hook ((rg-mode . wgrep-rg-setup)))
(rg-enable-default-bindings)

;; goto-addr
(use-package goto-addr
    :hook ((prog-mode . goto-address-prog-mode)
              (text-mode . goto-address-mode)))

;; swoop
(use-package swoop)
(setq swoop-minibuffer-input-dilay 0.4)

;; whitespace
(use-package whitespace)
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings
    '((space-mark ?\u3000 [?\u25a1])
         (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-tab "#adff2f")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#7cfc00")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(global-whitespace-mode 1)

;; dashboard
(use-package dashboard
    :ensure t
    :config
    (dashboard-setup-startup-hook))

;; company
(use-package company)
(global-company-mode)

;; git-gutter
(use-package git-gutter-fringe)
(global-git-gutter-mode +1)

;; smooth-scroll
(use-package smooth-scroll)
(smooth-scroll-mode t)

;; exec-path-from-shell
(use-package exec-path-from-shell)
(exec-path-from-shell-copy-envs '("PATH" "GEM_HOME"))

;; ghc
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

;; hindent
(add-hook 'haskell-mode-hook #'hindent-mode)
(setq hindent-style "johan-tibell")

;; typescript
(defun my/setup-tide-mode ()
    (interactive)
    (tide-setup)
    (tide-hl-identifier-mode +1))
(add-hook 'typescript-mode-hook #'my/setup-tide-mode)

;; js2-mode
(setq js2-skip-preprocessor-directives t)

;; sound-wav
;; (defun find-file-hook--sound ()
;;     (sound-wav-play
;;         (expand-file-name
;;             "~/sound/Typewriter_Sound_FXs/Antique_Typewriter_Sound_FXs/Paper_load.wav")))
;; (add-hook 'find-file-hook 'find-file-hook--sound)

;; (defun post-command-hook--sound ()
;;     (ignore-errors
;;         (sound-wav-play
;;             (expand-file-name
;;                 (cl-case last-command-event
;;                     (?\s "~/sound/Typewriter_Sound_FXs/Typewriter_Sound_FXs/Spacebar.wav")
;;                     ('backspace "~/sound/Typewriter_Sound_FXs/Typewriter_Sound_FXs/Backspace.wav")
;;                     ((?\C-m 'return) "~/sound/Typewriter_Sound_FXs/Typewriter_Sound_FXs/Return.wav")
;;                     (t (when (zerop (random 2))
;;                            "~/sound/Typewriter_Sound_FXs/Typewriter_Sound_FXs/2_click.wav")))))))
;; (add-hook 'post-command-hook 'post-command-hook--sound)
