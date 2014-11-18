(require 'auto-complete-config)

(ac-config-default)

(add-to-list 'ac-dictionary-directories (concat emacs-dir "modules/auto-complete/ac-dict"))

(setq ac-use-menu-map t)

(define-key ac-menu-map "\C-j" 'ac-next)

(define-key ac-menu-map "\C-k" 'ac-previous)

(add-to-list 'ac-modes 'html-mode)

(add-to-list 'ac-modes 'nxml-mode)

(setq ac-auto-show-menu 0
      ac-menu-height 4
      ac-auto-start 2
      ac-delay 0
      ac-candidate-limit 4)

(set-face-background 'ac-candidate-face "#2c2e2e")

(set-face-foreground 'ac-candidate-face "#9f9f9f")

(ac-set-trigger-key "TAB")

(setq ac-use-quick-help nil)

(provide 'init-auto-complete)
