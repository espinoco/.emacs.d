(require 'powerline)

(setq powerline-arrow-shape 'arrow14)

(setq-default mode-line-format
              (list "%e"
                    '(:eval (concat
                             (powerline-rmw 'left nil )
                             (powerline-buffer-id 'left nil powerline-color1 )
                             (powerline-narrow 'left powerline-color1 powerline-color2 )
                             (powerline-make-fill powerline-color2 )
                             (powerline-row 'right powerline-color1 powerline-color2 )
                             (powerline-make-text ":" powerline-color1 )
                             (powerline-column 'right powerline-color1 )
                             (powerline-percent 'right nil powerline-color1 )
                             (powerline-make-text " " nil )))))

(setq powerline-color1 "grey22")

(setq powerline-color2 "grey40")

(set-face-attribute 'mode-line nil
                    :foreground "#fdf6e3"
                    :background "#383838"
                    :box nil)

(set-face-attribute 'mode-line-inactive nil
                    :foreground "#6f6f6f"
                    :background "#494949"
                    :box nil)

(provide 'init-powerline)
