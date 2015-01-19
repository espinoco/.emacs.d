(require 'cl)

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-refresh-contents)

(provide 'packages)
