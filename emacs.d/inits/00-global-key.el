;;; key config

;; exchange alt <-> meta
(custom-set-variables
 '(ns-alternate-modifier 'alt)
 '(ns-command-modifier   'meta))

;; exchange C-j <-> C-m
(keyboard-translate ?\C-j ?\C-m)
(keyboard-translate ?\C-m ?\C-j)

;; global-set-key
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "C-l") 'other-window)
(define-key global-map (kbd "M-RET") 'toggle-frame-fullscreen)
