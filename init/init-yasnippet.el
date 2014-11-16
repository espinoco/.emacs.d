(require 'yasnippet)

;; The latest yasnippet and ac-source-yasnippet did not work together
(setq ac-source-yasnippet nil)

(yas-reload-all)

(yas-global-mode t)

(provide 'init-yasnippet)
