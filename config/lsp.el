;; ----- lsp ----- ;;

;;;;;;;;;;;;;;
;; lsp-mode ;;
;;;;;;;;;;;;;;
(use-package lsp-mode)

;; config
(setq lsp-print-io nil)
(setq lsp-trace nil)
(setq lsp-print-performance nil)
(setq lsp-auto-guess-root t)
(setq lsp-document-sync-method 'incremental)
(setq lsp-response-timeout 5)
(setq lsp-ui-sideline-enable nil)

;; hook
(add-hook 'go-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'lsp)
(add-hook 'web-mode-hook #'lsp)
(add-hook 'ruby-mode-hook #'lsp)

;;;;;;;;;;;;;;
;;  lsp-ui  ;;
;;;;;;;;;;;;;;
(use-package lsp-ui)

;; config
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-header t)
(setq lsp-ui-doc-include-signature t)
(setq lsp-ui-doc-max-width 150)
(setq lsp-ui-doc-max-height 30)
(setq lsp-ui-peek-enable t)

;; hook
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;;;;;;;;;;;;;;;;;
;; company-lsp ;;
;;;;;;;;;;;;;;;;;
(use-package company-lsp)

;; config
(push company-lsp company-backends)
(setq company-lsp-async t)
(setq company-lsp-cache-candidates t)

;;;;;;;;;;;;;;;;;
;;  dap-mode   ;;
;;;;;;;;;;;;;;;;;
(use-package dap-ruby)

;; config
(dap-mode 1)
(dap-ui-mode 1)
