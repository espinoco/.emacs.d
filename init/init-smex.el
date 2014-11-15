(require 'smex)

(setq smex-save-file (concat savefile-dir "/.smex-items"))

(setq smex-history-length 14
      smex-prompt-string ">> ")

(smex-initialize)

(provide 'init-smex)
