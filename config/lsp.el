;; ----- Lsp ----- ;;

;;;;;;;;;;;;;;
;; lsp-mode ;;
;;;;;;;;;;;;;;
(use-package lsp-mode)
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
(add-hook 'go-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'lsp)
(add-hook 'web-mode-hook #'lsp)
(add-hook 'ruby-mode-hook #'lsp)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'typescript-mode-hook #'lsp)
(add-hook 'vue-mode-hook #'lsp)
(add-hook 'sh-mode-hook #'lsp)
(add-hook 'shell-mode-hook #'lsp)
;; (add-hook 'php-mode-hook #'lsp)

;;;;;;;;;;;;;;
;;  lsp-ui  ;;
;;;;;;;;;;;;;;
(use-package lsp-ui)

;; config lsp-ui-doc
(setq lsp-ui-doc-enable t)

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

;;;;;;;;;;;;;;;;;
;;    ccls     ;;
;;;;;;;;;;;;;;;;;
(use-package ccls)

;; hook
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'objc-mode-hook 'lsp)
(add-hook 'cuda-mode-hook 'lsp)

;; config
(setq ccls-executable "~/.ghq/github.com/MaskRay/ccls/Release/ccls")
