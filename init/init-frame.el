;; Set frame size at start up
(add-to-list 'load-path "~/.emacs.d/extensions/frame")
(require 'frame-cmds)
(maximize-frame-horizontally)
(add-to-list 'default-frame-alist '(height . 48))

(provide 'init-frame)
