(defadvice sgml-delete-tag (after reindent-buffer activate)
  (cleanup-buffer))

(provide 'init-html)
