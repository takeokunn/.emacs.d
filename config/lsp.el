;; ----- Lsp ----- ;;

;;;;;;;;;;;;;;
;; lsp-mode ;;
;;;;;;;;;;;;;;
(use-package lsp-mode)
(use-package lsp-java)
(use-package lsp-haskell)

;; config
(setq lsp-print-io nil)
(setq lsp-trace nil)
(setq lsp-print-performance nil)
(setq lsp-auto-guess-root t)
(setq lsp-document-sync-method 'incremental)
(setq lsp-response-timeout 5)
(setq lsp-ui-sideline-enable nil)
(setq lsp-prefer-flymake nil)

;; path
(add-to-list 'exec-path "~/.npm-global/bin" t)

;; hook
(dolist (hook '(go-mode-hook
                   js2-mode-hook
                   web-mode-hook
                   css-mode-hook
                   scss-mode-hook
                   ruby-mode-hook
                   haskell-mode-hook
                   typescript-mode-hook
                   java-mode-hook
                   vue-mode-hook
                   sh-mode-hook
                   shell-mode-hook
                   php-mode-hook))
    (add-hook hook #'lsp))
(add-hook 'lsp-mode-hook 'flycheck-mode)

;;;;;;;;;;;;;;
;;  lsp-ui  ;;
;;;;;;;;;;;;;;
(use-package lsp-ui)

;; config lsp-ui-doc
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-max-height 15)

;; config lsp-ui-sideline
(setq lsp-ui-sideline-enable nil)

;; config lsp-ui-imenu
(setq lsp-ui-imenu-enable nil)

;; hook
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;;;;;;;;;;;;;;;;;
;; company-lsp ;;
;;;;;;;;;;;;;;;;;
(use-package company-lsp)

;; push
(push 'company-lsp company-backends)

;;;;;;;;;;;;;;;;;
;;  dap-mode   ;;
;;;;;;;;;;;;;;;;;
(use-package dap-php)
(use-package dap-node)
(use-package dap-ruby)
(use-package dap-chrome)

;; config
(dap-mode 1)
(dap-ui-mode 1)

;; ;;;;;;;;;;;;;;;;;
;; ;;  lsp-glsl   ;;
;; ;;;;;;;;;;;;;;;;;
;; (lsp-register-client
;;     (make-lsp-client
;;         :new-connection (lsp-stdio-connection '("glslls"))
;;         :major-modes '(glsl-mode)
;;         :server-id 'glsl-ls
;;         :multi-root t))
;; (add-hook 'glsl-mode-hook #'lsp)
