;; Format
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;; === === === USER INTERFACE === === === ;;
(tool-bar-mode -1) ;; tool bar are hidden
(menu-bar-mode -1) ;; menu bar are hidden
;; --- --- font --- --- ;;
(let ((ws system-type))
  (cond
    ((equal ws 'w32)    (add-to-list 'default-frame-alist '(font . "Consolas")))
    ((equal ws 'ns)     (add-to-list 'default-frame-alist '(font . "ricty-16")))
    ((equal ws 'darwin) (add-to-list 'default-frame-alist '(font . "ricty-16")))))

;; --- --- current line highlighted --- --- ;;
(global-hl-line-mode 1)

;; --- --- stop Flashing cursor --- ---
(blink-cursor-mode 0)

;; ---- ---- indent ---- ---- ;;
(setq-default tab-width 2 indent-tabs-mode nil)

;; --- --- back --- --- ;;
(define-key global-map [?¥] [?\\])

;; --- --- Scroll line by line --- --- ;;
(setq scroll-conservatively 1)

;; --- --- line & column number displayed --- --- ;;
(line-number-mode 1)
(column-number-mode 1)

;; scroll bar hidden
(if window-system
  (set-scroll-bar-mode nil))

;; line number displayed
(global-linum-mode t)
(setq linum-format "%4d ")

;; startup hidden
(setq inhibit-startup-screen t)

;; --- --- garbage collection --- ---
(setq gc-cons-threshold (* 20 gc-cons-threshold))

;; auto save file
(setq make-backup-files nil) 
(setq auto-save-default nil)

;;; === === === Package === === === ;;;
(add-to-list 'load-path "~/.emacs.d/funs/")
(require 'shkw)
(require 'shkw-latex)
(require 'shkw-ocaml)
(require 'shkw-lisp)

;; ---- ---- template ---- ---- ;;
(auto-insert-mode)
(setq-default auto-insert-directory "~/.emacs.d/Template/")
(define-auto-insert "\\.tex$" "shkw-latex-template.tex")

;; ---- ---- package ---- ---- ;;
(require 'package)

;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; MELPA-stableを追加
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Marmaladeを追加
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; Orgを追加
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; 初期化
(package-initialize)
;; ---- ---- powerline ---- ---- ;;
(require 'powerline)
(powerline-center-theme)

;; ==== ==== ==== Color ==== ==== ==== ;;
(add-to-list 'load-path "~/.emacs.d/elisp/themes")
(load-theme #'rebecca t)

;; ---- ---- auto-complete ---- ---- ;;
(ac-config-default)
(ac-set-trigger-key "TAB")
(global-auto-complete-mode t)
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)

;; ---- ---- rainbow ---- ---- ;;
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; param color
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;; ---- ---- helm ---- ---- ;;
(require 'helm)
(require 'helm-config)
(helm-mode 1)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)

;; ==== ==== ==== Languages ==== ==== ==== ;;
;; ---- ---- Coq ---- ---- ;;
;; ---- ---- Proof ---- ---- ;;
(load "~/.emacs.d/lisp/PG/generic/proof-site")
;; ---- ---- yatex ---- ---- ;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
;; ---- ---- TeX , LaTeX ---- ---- ;;
(add-to-list 'auto-mode-alist '("\\.tex$" . shkw-latex-mode))
(add-to-list 'auto-mode-alist '("\\.ltx$" . shkw-latex-mode))
(add-to-list 'auto-mode-alist '("\\.sty$" . shkw-latex-mode))
;; ---- ---- SML ---- ---- ;;
(add-to-list 'auto-mode-alist '("\\.sml$" . sml-mode))
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4e4d9f6e1f5b50805478c5630be80cce40bee4e640077e1a6a7c78490765b03f" default)))
 '(package-selected-packages (quote (powerline rainbow-delimiters helm auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
