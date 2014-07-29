(add-to-list 'load-path "~/.emacs.d/extensions/change-windows-intuitively")
(require 'change-windows-intuitively)
(require 'gnus)

(global-set-key (kbd "C-M-j") 'proff-select-window-left)
(global-set-key (kbd "C-M-l") 'proff-select-window-right)
(global-set-key (kbd "C-M-k") 'proff-select-window-down)

(add-hook 'completion-at-point-functions
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'shell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'eshell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'eshell-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-l") 'proff-select-window-right)))

(add-hook 'nxml-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-M-i") 'proff-select-window-up)))

(define-key gnus-summary-mode-map (kbd "C-M-i") 'proff-select-window-up)

(define-key gnus-summary-mode-map (kbd "C-M-k") 'proff-select-window-down)

(define-key gnus-summary-mode-map (kbd "C-M-l") 'proff-select-window-right)

(provide 'init-change-windows-intuitively)
