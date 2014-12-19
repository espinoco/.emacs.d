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

(setq ace-jump-mode-scope 'window)

(setq ace-jump-mode-move-keys
      (loop for i from ?a to ?z collect i))

(setq ace-jump-mode-case-fold nil)

(provide 'init-ace-jump-mode)
