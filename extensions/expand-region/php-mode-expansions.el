;;; php-mode-expansions.el --- PHP-specific expansions for expand-region

;; Copyright (C) 2011 Carlo Rodríguez

;; Author: Carlo Rodríguez <carloeduardorodriguez@gmail.com>
;; Keywords: marking region

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(require 'expand-region-core)

(defun er/mark-php-variable-name ()
  "Marks one PHP variable name, eg. myVar instead of $myVar"
  (interactive)
  (search-backward "$")
  (forward-char)
  (set-mark (point))
  (search-forward ";")
  (backward-char)
  (exchange-point-and-mark))

(defun er/add-php-mode-expansions ()
  "Adds PHP-specific expansions for buffers in PHP-mode"
  (set (make-local-variable 'er/try-expand-list) (append
                                                  er/try-expand-list
                                                  '(er/mark-php-variable-name))))

(er/enable-mode-expansions 'php-mode 'er/add-php-mode-expansions)

(provide 'php-mode-expansions)
