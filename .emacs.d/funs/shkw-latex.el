;;; shkw-latex.el

;; Copyright (C) 2016  shinkwhek

;; Author: shinkwhek
(provide 'shkw-latex)

(defvar shkw-latex-mode-map
  (let ((km (make-keymap)))
    (progn
      (define-key km (kbd "C-c C-e") 'shkw-insert-env)
      (define-key km (kbd "(") 'shkw-insert-parentheses)
      (define-key km (kbd "{") 'shkw-insert-brackets)
      km)))

;; ==== ==== ==== Color ==== ==== ==== ;;
(defface shkw-spell-color
  '((t (:foreground "#ff6100" :background "#f2f2f2")))
  "general")
(defface shkw-expand-color
  '((t (:foreground "#ff0000" :background "#f2f2f2" :weight bold)))
  "expand")
(defface shkw-env-color
  '((t (:foreground "#ff0090" :background "#f2f2f2")))
  "environment")
(defface shkw-special-spell-color
  '((t (:foreground "#01a525" :background "#f2f2f2")))
  "special-spell")
(defface shkw-makeatletter-color
  '((t (:foreground "#d000ff" :background "#f2f2f2")))
  "make-at")

;; ==== ==== ==== Map ==== ==== ==== ;;
(define-generic-mode shkw-latex-mode
  '("%")
  '()
  '(("\\(\\\\[a-zA-Z@]+\\)\\>"
     (1 'shkw-spell-color t))
    ("\\(\\\\\\(?:expandafter\\|noexpand\\)\\)\\>"
     (1 'shkw-expand-color t))
    ("\\(\\\\\\(?:begin\\|end\\)\\)\\>"
     (1 'shkw-env-color t))
    ("\\(\\\\\\(?:def\\|if\\|else\\|or\\|fi\\|let\\|advance\\|multiply\\|newcount\\|newdimen\\|newskip\\|newtoks\\|newif\\|gdef\\|global\\)\\)\\>"
     (1 'shkw-special-spell-color t))
    ("\\(\\\\\\(?:makeatletter\\|makeatother\\)\\)\\>"
     (1 'shkw-makeatletter-color t)))
  '(".+\\.\\(tex\\|sty\\)")
  '((lambda ()
      (progn
	(use-local-map shkw-latex-mode-map)
	(setq mode-name "shkw-LaTeX"))))
  "shkw-LaTeX")

;; ==== ==== ==== Functions ==== ==== ==== ;;
;; ---- ---- shkw-insert-env ---- ---- ;;
(defun shkw-insert-env (envName)
  (interactive "sEnvName: ")
  (progn
    (insert (format "\\begin{%s}\n \n\\end{%s}" envName envName))
    (forward-line (- (line-number-at-pos) 1))))
;; ---- ---- shkw-insert-brackets ---- ---- ;;
(defun shkw-insert-brackets ()
  (interactive)
  (progn
    (insert (format "{}"))
    (forward-char (- 1))))
;; ---- ---- shkw-insert-parentheses ---- ---- ;;
(defun shkw-insert-parentheses ()
  (interactive)
  (progn
    (insert (format "()"))
    (forward-char (- 1))))
