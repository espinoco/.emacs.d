(require 'projectile)

(projectile-global-mode)

(setq projectile-enable-caching t)

(setq projectile-file-exists-remote-cache-expire nil)

(setq projectile-enable-caching nil)

(provide 'init-projectile)
