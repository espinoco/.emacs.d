(add-to-list 'load-path "~/.emacs.d/extensions/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/extensions/yasnippet/snippets"))
;; The latest yasnippet and ac-source-yasnippet did not work together
(setq ac-source-yasnippet nil)

(provide 'init-yasnippet)
