(add-to-list 'load-path "~/.emacs.d/extensions/key-chord")
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "mx" 'execute-extended-command)

(provide 'init-key-chord)
