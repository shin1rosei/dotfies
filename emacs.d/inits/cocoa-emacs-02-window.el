;;; window.el --- Window setting for cocoa emacs

;;; Commentary:

;;; Code:
(custom-set-variables
 '(tool-bar-mode nil)                   ; hide tool bar
 '(scroll-bar-mode nil)                 ; hide scroll bar
 '(ns-use-native-fullscreen nil)        ; no native fullscreen
 '(initial-frame-alist
   '((alpha . 80))))

(setq ns-use-native-fullscreen nil)
(setq ns-pop-up-frames nil)

;;; cocoa-emacs-02-window.el ends here
