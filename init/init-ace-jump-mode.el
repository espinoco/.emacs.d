(add-to-list 'load-path "~/.emacs.d/extensions/ace-jump-mode")

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)

(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))

(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(setq ace-jump-mode-scope 'window)

(setq ace-jump-mode-move-keys
      (loop for i from ?a to ?z collect i))

(provide 'init-ace-jump-mode)
