(tool-bar-mode -1)

(scroll-bar-mode -1)

(menu-bar-mode -1)

(global-hl-line-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(require 'solarized-theme)

(load-theme 'solarized-dark t)

(global-hl-line-mode 1)

(setq ns-use-srgb-colorspace nil)

(provide 'ui)
