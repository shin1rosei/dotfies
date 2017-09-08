;;; window.el --- Window setting for cocoa emacs

;;; Commentary:

;;; Code:
(custom-set-variables
 '(tool-bar-mode nil)                   ; hide tool bar
 '(scroll-bar-mode nil)                 ; hide scroll bar
 '(ns-use-native-fullscreen nil)        ; no native fullscreen
 '(initial-frame-alist
   '((alpha . 100))))

(setq ns-use-native-fullscreen nil)
(setq ns-pop-up-frames nil)

;;; theme;
;; (require 'color-theme-tomorrow)
;; (color-theme-tomorrow--define-theme night-eighties)
;; (color-theme-tomorrow--define-theme day)
;; (require 'color-theme)
;; (require 'color-theme-solarized)
;; (load-theme 'solarized-dark t)
(require 'color-theme-tomorrow)
(color-theme-tomorrow--define-theme night-eighties)
;;; cocoa-emacs-02-window.el ends here
