(require 'ido-vertical-mode)

(ido-vertical-mode 1)

(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

(defun vim-ido-vertical-define-keys ()
  (when ido-vertical-define-keys
    (define-key ido-completion-map (kbd "C-j") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-k") 'ido-prev-match)
    (define-key ido-completion-map (kbd "<return>") 'ido-select-text)
    (define-key ido-completion-map (kbd "M-p") 'ido-toggle-prefix))
  (when (memq ido-vertical-define-keys '(C-n-C-p-up-and-down C-n-C-p-up-down-left-right))
    (define-key ido-completion-map (kbd "<up>") 'ido-prev-match)
    (define-key ido-completion-map (kbd "<down>") 'ido-next-match))
  (when (eq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
    (define-key ido-completion-map (kbd "<left>") 'ido-vertical-prev-match)
    (define-key ido-completion-map (kbd "<right>") 'ido-vertical-next-match)))

(add-hook 'ido-setup-hook 'vim-ido-vertical-define-keys)

(provide 'init-ido-vertical-mode)
