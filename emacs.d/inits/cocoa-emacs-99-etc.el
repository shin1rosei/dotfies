;;; custom variables
(custom-set-variables
 '(dired-use-ls-dired nil))             ; dired ls

(define-key global-map [165] [92]) ;; 165が¥（円マーク） , 92が\（バックスラッシュ）を表す

;; mode lineが長くなるのを防ぐ
(setq my/hidden-minor-modes
      '(undo-tree-mode
        eldoc-mode
        auto-complete-mode
        magit-auto-revert-mode
        abbrev-mode
        git-gutter-mode
        helm-mode))

(mapc (lambda (mode)
          (setq minor-mode-alist
                (cons (list mode "") (assq-delete-all mode minor-mode-alist))))
        my/hidden-minor-modes)
