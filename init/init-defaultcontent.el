(require 'defaultcontent)

(setq dc-auto-insert-directory (concat modules-dir "/defaultcontent/dc-dir"))

(setq dc-auto-insert-alist
      '(
        ("\\.py$" . "insert.py")
        ("\\Actor.java$" . "actor.java")
        ("\\Screen.java$" . "screen.java")
        ))

(provide 'init-defaultcontent)
