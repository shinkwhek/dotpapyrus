(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
;; ==== ==== ==== FileType ==== ==== ==== ;;
;; ---- ---- TeX , LaTeX ---- ---- ;;
(add-to-list 'auto-mode-alist '("\\.tex$" . shkw-latex-mode))
(add-to-list 'auto-mode-alist '("\\.ltx$" . shkw-latex-mode))
(add-to-list 'auto-mode-alist '("\\.sty$" . shkw-latex-mode))
;; ---- ---- C/C++ ---- ---- ;;
(add-to-list 'auto-mode-alist '("\\.c$"   . shkw-c-mode))
(add-to-list 'auto-mode-alist '("\\.h$"   . shkw-c-mode))
(add-to-list 'auto-mode-alist '("\\.cpp$" . shkw-c-mode))
(add-to-list 'auto-mode-alist '("\\.hpp$" . shkw-c-mode))
;; ---- ---- SML ---- ---- ;;
(add-to-list 'auto-mode-alist '("\\.sml$" . sml-mode))
;;
;; === === === USER INTERFACE === === === ;;
;; --- --- tool bar & menu bar are hidden --- --- ;;
(tool-bar-mode -1)
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

;; ---- ---- indent ---- ---- ;;
(setq default-tab-width 4)

;; --- --- balanced paren shown --- --- ;;
(show-paren-mode 1)

;; --- --- line & column number displayed --- --- ;;
(line-number-mode 1)
(column-number-mode 1)

;; scroll bar hidden
(set-scroll-bar-mode nil)

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
;; ---- ---- background ---- ---- ;;
(set-face-background 'default "#303030")
(set-face-foreground 'default "#f0f0f0")

;;; === === === Package === === === ;;;
(add-to-list 'load-path "~/.emacs.d/funs")
(require 'shkw)
(require 'shkw-latex)
(require 'shkw-c)

;; ==== ==== ==== Company ==== ==== ==== ;;
;; ---- ---- initial ---- ---- ;;
(add-hook 'after-init-hook 'global-company-mode)
;(global-company-mode +1)


;; ---- ---- company color ---- ---- ;;

;; ---- ---- template ---- ---- ;;
(auto-insert-mode)
(setq-default auto-insert-directory "~/.emacs.d/Template/")
(define-auto-insert "\\.tex$" "shkw-latex-template.tex")

;; ---- ---- package ---- ---- ;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; ==== ==== ==== Languages ==== ==== ==== ;;

;; ---- ---- Coq ---- ---- ;;
;; ---- ---- Proof ---- ---- ;;
(load "~/.emacs.d/lisp/PG/generic/proof-site")

;; ---- ---- OCaml ---- ---- ;;
(when (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

(setq opam-share
      (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'utop)

;; ---- ---- yatex ---- ---- ;;
(add-to-list 'load-path "~/.emacs.d/site-lisp/yatex")
