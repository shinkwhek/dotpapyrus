(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;; ==== ==== ==== FileType ==== ==== ==== ;;
;; ---- ---- TeX , LaTeX ---- ---- ;;
(add-to-list 'auto-mode-alist '("\\.tex$" . shkw-latex-mode))
(add-to-list 'auto-mode-alist '("\\.ltx$" . shkw-latex-mode))
(add-to-list 'auto-mode-alist '("\\.sty$" . shkw-latex-mode))
;; ---- ---- SML ---- ---- ;;
(add-to-list 'auto-mode-alist '("\\.sml$" . sml-mode))
;;
;; === === === USER INTERFACE === === === ;;
;; --- --- tool bar & menu bar are hidden --- --- ;;
(if window-system
	(tool-bar-mode -1))
(menu-bar-mode -1)
;; --- --- font --- --- ;;
(let ((ws window-system))
  (cond ((eq ws 'w32)
	 (set-face-attribute 'default nil
			     :family "Consolas"
			     :height 130)
	 (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Meiryo UI")))
	((eq ws 'ns)
	 (set-face-attribute 'default nil
			     :family "Monaco"
			     :height 130)
	 (set-fontset-font nil 'japanese-jisx0208 (font-spec :family "Osaka")))))

;; --- --- current line highlighted --- --- ;;
(global-hl-line-mode 1)

;; --- --- stop Flashing cursor --- ---
(blink-cursor-mode 0)

;; ---- ---- indent ---- ---- ;;
(setq tab-width 2)

;; --- --- balanced paren shown --- --- ;;
(show-paren-mode 1)

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

;; ==== ==== ==== Color ==== ==== ==== ;;
(load-theme 'tango-dark t)

;;; === === === Package === === === ;;;
(add-to-list 'load-path "~/.emacs.d/funs")
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
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; ---- ---- auto-complete ---- ---- ;;
(ac-config-default)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)

;; ---- ---- helm ---- ---- ;;
(require 'helm)
(helm-mode 1)
(define-key global-map (kbd "M-x") 'helm-M-x)
(define-key global-map (kbd "C-x C-f") 'helm-find-files)

;; ==== ==== ==== Languages ==== ==== ==== ;;

;; ---- ---- Coq ---- ---- ;;
;; ---- ---- Proof ---- ---- ;;
(load "~/.emacs.d/lisp/PG/generic/proof-site")


;; ---- ---- yatex ---- ---- ;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
