(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/extensions/auto-complete/ac-dict")

(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

(add-to-list 'ac-modes 'html-mode)
(add-to-list 'ac-modes 'nxml-mode)

(setq ac-auto-show-menu 0
      ac-menu-height 3
      ac-auto-start 2
      ac-delay 0)

(provide 'init-auto-complete)
