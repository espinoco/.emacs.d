(add-to-list 'load-path "~/.emacs.d/extensions/key-chord")
(require 'key-chord)
(key-chord-mode 1)

;; Spanish keyboard isn't very friendly with programmers, so I got to remap
;; ñ key to semi-colon, that's why I got to use "ññ" instead of ";;"
(key-chord-define-global "ññ"  "\C-e;")
(key-chord-define-global "hj" 'undo)

(provide 'init-key-chord)
