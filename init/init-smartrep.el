(require 'smartrep)

(global-set-key "\C-w" nil)

(smartrep-define-key
    global-map "C-w" '(("q" . 'delete-window)
                       ("o" . 'delete-other-windows)
                       ("s" . 'switch-to-buffer-other-bottom-window)
                       ("v" . 'switch-to-buffer-other-side-window)
                       ("k" . 'windmove-up)
                       ("j" . 'windmove-down)
                       ("h" . 'windmove-left)
                       ("l" . 'windmove-right)))

(global-set-key "\C-l" nil)

(smartrep-define-key
    global-map "C-l" '(("j" . 'mc/mark-next-like-this)
                       ("k" . 'mc/mark-previous-like-this)
                       ("a" . 'mc/mark-all-like-this)
                       ("s" . 'mc/skip-to-next-like-this)))

(provide 'init-smartrep)
