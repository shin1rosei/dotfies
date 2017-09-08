;;; window
(custom-set-variables
 '(menu-bar-mode nil))

;; color
(set-background-color "black")
(set-foreground-color "white")
;;;(load-theme 'solarized-dark t)

;; scroll
;; use smooth-scroll, yascroll
(require 'smooth-scroll)
(require 'yascroll)
(smooth-scroll-mode t)
(global-yascroll-bar-mode t)
(custom-set-variables
 '(smooth-scroll/vscroll-step-size 10))
(custom-set-faces
 '(yascroll:thumb-fringe ((t (:background "slate gray" :foreground "slate gray")))))

;; mode line
;; (require 'powerline)
;; (powerline-vim-theme)
;;(custom-set-faces
;; '(mode-line ((t (:background "LightGreen" :foreground "black" :box (:line-width -1 :style released-button)))))
;; '(powerline-active1 ((t (:background "LightPink2" :inherit mode-line))))
;; '(powerline-active2 ((t (:background "LightSkyBlue3" :inherit mode-line)))))

;; visible-bell
(setq visible-bell nil)
(setq ring-bell-function '(lambda ()))

;; スクロール調整
(setq scroll-conservatively 35
      scroll-margin 0
      scroll-step 1)

;; 縦分割とかでも行を折り返す
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; 折り返しトグル
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; 行カーソル
(global-hl-line-mode t)

(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))
(setq global-hl-line-timer
      (run-with-idle-timer 0.1 t 'global-hl-line-timer-function))

;; (cancel-timer global-hl-line-timer)
