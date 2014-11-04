(require 'helm-config)

(helm-mode 1)

(setq helm-completing-read-handlers-alist
   (quote
    ((describe-function . ido)
     (describe-variable . ido)
     (debug-on-entry . helm-completing-read-symbols)
     (find-function . helm-completing-read-symbols)
     (find-tag . helm-completing-read-with-cands-in-buffer)
     (ffap-alternate-file)
     (tmm-menubar)
     (dired-do-copy . ido)
     (mml-attach-file . ido)
     (byte-recompile-directory . ido)
     (dired-do-rename . ido)
     (dired-create-directory . ido)
     )))

(provide 'init-helm)
