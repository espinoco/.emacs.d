(add-to-list 'load-path "~/.emacs.d/extensions/smex")
(require 'smex)
(setq smex-history-length 14
      smex-prompt-string "=> ")
(smex-initialize)

(provide 'init-smex)
