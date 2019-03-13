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

;; hook
(add-hook 'go-mode-hook #'lsp)
(add-hook 'js2-mode-hook #'lsp)

;; func
(defun lsp-mode-init ()
    (lsp)
    (global-set-key (kbd "M-*") 'xref-pop-marker-stack)
    (global-set-key (kbd "M-.") 'xref-find-definitions)
    (global-set-key (kbd "M-/") 'xref-find-references))


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
(setq company-lsp-async t)
(setq company-lsp-cache-candidates t)
