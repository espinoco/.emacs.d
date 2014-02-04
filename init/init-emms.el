(add-to-list 'load-path "~/.emacs.d/extensions/emms/lisp")
(require 'emms-setup)
(require 'emms-player-vlc)
(emms-standard)
(emms-default-players)
(setq emms-player-vlc-command-name
      "/Applications/VLC.app/Contents/MacOS/VLC")

(defun emms-play-video-file(video-file-name)
  "Plays video file with VLC by directly opening VLC"
  (interactive (list (read-file-name "Play video file: ")))
  (shell-command (format "%s --quiet --fullscreen \"%s\""
                         emms-player-vlc-command-name
                         video-file-name) nil nil))

(provide 'init-emms)
