(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)

(add-to-list 'load-path
             (expand-file-name "/usr/local/Cellar/ledger/3.1/share/emacs/site-lisp/ledger/"))

(add-to-list 'auto-mode-alist '("\\.hledger.journal$" . ledger-mode))

(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

(provide 'init-ledger)
