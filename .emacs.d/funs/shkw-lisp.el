;;; shkw-lisp.el --- setting of scheme(gauche)       -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Shin KAWAHARA

;; Author: Shin KAWAHARA

(provide 'shkw-lisp)
;;; shkw-lisp.el ends here

;; 対応する括弧を表示する
(show-paren-mode t)
;; 括弧の補完
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;; emacsでGauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "/usr/local/bin/gosh -i")

(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window ()
  "Run Gauche on other window"
  (interactive)
  (split-window-horizontally (/ (frame-width) 2))
  (let ((buf-name (buffer-name (current-buffer))))
    (scheme-mode)
    (switch-to-buffer-other-window
     (get-buffer-create "*scheme*"))
    (run-scheme scheme-program-name)
    (switch-to-buffer-other-window
     (get-buffer-create buf-name))))

(define-key global-map
  "\C-cG" 'scheme-other-window)
