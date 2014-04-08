(add-to-list 'load-path "~/.emacs.d/extensions/highlight-symbol")
(require 'highlight-symbol)
(global-set-key [(control f9)] 'highlight-symbol-at-point)
(global-set-key [f9] 'highlight-symbol-next)
(global-set-key [(shift f9)] 'highlight-symbol-prev)
(global-set-key [(meta f9)] 'highlight-symbol-query-replace)

(provide 'init-highlight-symbol)
