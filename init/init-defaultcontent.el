(require 'defaultcontent)

(setq dc-auto-insert-directory (concat modules-dir "/defaultcontent/dc-dir"))

(setq dc-auto-insert-alist
      '(("\\.py$" . "insert.py")))

(provide 'init-defaultcontent)
