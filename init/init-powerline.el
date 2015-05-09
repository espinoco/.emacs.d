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

(setq powerline-color1 "#515151")

(setq powerline-color2 "#393939")

(set-face-attribute 'mode-line nil
                    :foreground "#393939"
                    :background "#cccccc"
                    :overline nil
                    :underline nil
                    :box nil)

(set-face-attribute 'mode-line-inactive nil
                    :overline nil
                    :underline nil
                    :box nil)

(provide 'init-powerline)
