(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)

(autoload
  'ace-jump-char-mode
  "ace-jump-mode"
  "Emacs quick move by char"
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

(require 'ace-jump-mode)

(set-face-attribute 'ace-jump-face-foreground nil
                    :weight 'bold
                    :foreground "#ffcc66")

(provide 'init-ace-jump-mode)
