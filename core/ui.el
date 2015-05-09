(tool-bar-mode -1)

(scroll-bar-mode -1)

(menu-bar-mode -1)

(global-hl-line-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(load (concat emacs-dir "themes/tomorrow-theme/color-theme-tomorrow"))

(add-to-list 'custom-theme-load-path
             (concat emacs-dir "themes/tomorrow-theme"))

(load-theme 'tomorrow-night-eighties t)

(global-hl-line-mode 1)

(setq ns-use-srgb-colorspace nil)

(provide 'ui)
