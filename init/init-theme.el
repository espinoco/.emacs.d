(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

(require 'cl)

(defun set-solarized-dark-theme ()
  (interactive)
  (custom-set-faces
   '(helm-match ((t (:inherit match :background "black"))))
   '(helm-selection ((t (:background "navy" :underline t))))
   '(yas/field-highlight-face ((t (:background "dark blue")))))
  (load-theme 'solarized-dark t))

(defun set-solarized-light-theme ()
  (interactive)
  (custom-set-faces
   '(helm-match ((t (:inherit match))))
   '(helm-selection ((t (:background "#b5ffd1" :underline t))))
   '(yas/field-highlight-face ((t (:background unspecified)))))
  (load-theme 'solarized-light t))

(load-theme 'zenburn t)

;; (set-face-attribute 'region nil :foreground "#c9bb9b" :background "#2b2b2b")
(global-hl-line-mode 1)
(set-face-background hl-line-face "#434443")

(provide 'init-theme)
