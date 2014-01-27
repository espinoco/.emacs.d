;; change-windows-intuitively.el (c) 1998 Julian Assange <proff@iq.org>
;; move around (x)emacs windows intuitively (e.g
;; take me to the window to the immediate left/right/top/bottem of
;; the current one)
;;
;; TODO move relative to the cursor, rather than relative
;; to the currently selected window (which in some
;; circumstances i.e when you have a lot of different size
;; windows stacked near each other, is is more intuitive).
;;
;; uncomment the following keybindings if you like them -
;; note however that shift+arrow keys may not be bindable
;; on your terminal (e.g if you are not running X)

;; (global-set-key [(shift left)] 'proff-select-window-left)
;; (global-set-key [(shift right)] 'proff-select-window-right)
;; (global-set-key [(shift up)] 'proff-select-window-up)
;; (global-set-key [(shift down)] 'proff-select-window-down)

(global-set-key (kbd "C-S-j") 'proff-select-window-left)
(global-set-key (kbd "C-S-l") 'proff-select-window-right)
(global-set-key (kbd "C-S-i") 'proff-select-window-up)
(global-set-key (kbd "C-S-k") 'proff-select-window-down)

(defun proff-find-window-down (win)
  (let ((swin))
    (walk-windows
     (lambda (wwin)
       (and (<= (nth 0 (window-pixel-edges wwin))
		(nth 0 (window-pixel-edges win)))
	    (> (nth 2 (window-pixel-edges wwin))
	       (nth 0 (window-pixel-edges win)))
	    (> (nth 1 (window-pixel-edges wwin))
	       (nth 1 (window-pixel-edges win)))
	    (or (not swin)
		(< (nth 1 (window-pixel-edges wwin))
		   (nth 1 (window-pixel-edges swin))))
	    (setq swin wwin)))
     nil)
    swin))

(defun proff-select-window-down ()
  (interactive)
  (let ((win (proff-find-window-down (selected-window))))
    (if win (select-window win))))

(defun proff-find-window-up (win)
  (let ((swin))
    (walk-windows
     (lambda (wwin)
       (and (<= (nth 0 (window-pixel-edges wwin))
		(nth 0 (window-pixel-edges win)))
	    (> (nth 2 (window-pixel-edges wwin))
	       (nth 0 (window-pixel-edges win)))
	    (< (nth 1 (window-pixel-edges wwin))
	       (nth 1 (window-pixel-edges win)))
	    (or (not swin)
		(> (nth 1 (window-pixel-edges wwin))
		   (nth 1 (window-pixel-edges swin))))
	    (setq swin wwin)))
     nil)
    swin))

(defun proff-select-window-up ()
  (interactive)
  (let ((win (proff-find-window-up (selected-window))))
    (if win (select-window win))))

(defun proff-find-window-left (win)
  (let ((swin))
    (walk-windows
     (lambda (wwin)
       (and (<= (nth 1 (window-pixel-edges wwin))
		(nth 1 (window-pixel-edges win)))
	    (> (nth 3 (window-pixel-edges wwin))
	       (nth 1 (window-pixel-edges win)))
	    (< (nth 0 (window-pixel-edges wwin))
	       (nth 0 (window-pixel-edges win)))
	    (or (not swin)
		(> (nth 0 (window-pixel-edges wwin))
		   (nth 0 (window-pixel-edges swin))))
	    (setq swin wwin)))
     nil)
    swin))

(defun proff-select-window-left ()
  (interactive)
  (let ((win (proff-find-window-left (selected-window))))
    (if win (select-window win))))

(defun proff-find-window-right (win)
  (let ((swin))
    (walk-windows
     (lambda (wwin)
       (and (<= (nth 1 (window-pixel-edges wwin))
		(nth 1 (window-pixel-edges win)))
	    (> (nth 3 (window-pixel-edges wwin))
	       (nth 1 (window-pixel-edges win)))
	    (> (nth 0 (window-pixel-edges wwin))
	       (nth 0 (window-pixel-edges win)))
	    (or (not swin)
		(< (nth 0 (window-pixel-edges wwin))
		   (nth 0 (window-pixel-edges swin))))
	    (setq swin wwin)))
     nil)
    swin))

(defun proff-select-window-right ()
  (interactive)
  (let ((win (proff-find-window-right (selected-window))))
    (if win (select-window win))))

(provide 'change-windows-intuitively)
