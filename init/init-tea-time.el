(require 'tea-time)
(setq tea-time-sound "~/Music/your-turn.mp3")
(setq tea-time-sound-command "afplay %s")
(setq tea-time-notification-message "I know you're busy but it's TEA TIME!")
(setq tea-time-notification-title "Excuse me Master")

(add-hook 'tea-time-notification-hook
  (lambda ()
    (call-process-shell-command
     (format
      "terminal-notifier -message \"%s\" -title \"%s\" -group 78904269 -sender org.gnu.Emacs"
      tea-time-notification-message
      tea-time-notification-title)
     nil
     "*Shell Command Output*"
     t)))

(provide 'init-tea-time)
