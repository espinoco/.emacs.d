(require 'calendar)

(setq holiday-general-holidays 'nil
      holiday-solar-holidays 'nil
      holiday-bahai-holidays 'nil
      holiday-christian-holidays 'nil
      holiday-hebrew-holidays 'nil
      holiday-islamic-holidays 'nil
      holiday-oriental-holidays 'nil
      holiday-other-holidays 'nil)

(setq holiday-local-holidays
      '((holiday-fixed 1 1 "Año nuevo")
        (holiday-fixed 2 5 "Día de la Constitución Mexicana")
        (holiday-fixed 2 14 "Día de San Valentín")
        (holiday-fixed 4 30 "Día del niño")
        (holiday-fixed 5 10 "Día de la madre")
        (holiday-fixed 5 5 "Batalla de puebla")
        (holiday-fixed 3 21 "Natalicio de Benito Juárez")
        (holiday-fixed 1 5 "Día del trabajo")
        (holiday-fixed 9 16 "Independencia de México")
        (holiday-fixed 11 2 "Día de los muertos")
        (holiday-fixed 11 20 "Revolución Mexicana")
        (holiday-fixed 12 24 "Noche buena")
        (holiday-fixed 12 25 "Navidad")
        (holiday-float 6 0 3 "Día del padre")))

(setq calendar-mark-holidays-flag t)

(define-key calendar-mode-map (kbd "q") 'delete-window)

(provide 'init-calendar)