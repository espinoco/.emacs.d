(add-to-list 'load-path "~/.emacs.d/extensions/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

;; The latest yasnippet and ac-source-yasnippet did not work together
(setq ac-source-yasnippet nil)

(provide 'init-yasnippet)
