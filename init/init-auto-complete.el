(add-to-list 'load-path "~/.emacs.d/extensions/auto-complete")
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/extensions/auto-complete/ac-dict")

;; Select candidates with C-n/C-p only when completion menu is displayed
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(provide 'init-auto-complete)
