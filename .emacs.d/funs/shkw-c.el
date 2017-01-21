;;; shkw-c.el 

;; Copyright (C) 2016  shinkwhek

;; Author: shinkwhek
(provide 'shkw-c)

(defvar shkw-c-mode-map
  (let ((km (make-keymap)))
    (progn
      km)))

;; ==== ==== ==== Color ==== ==== ==== ;;
(defface shkw-primitive-type-color
  '((t (:foreground "#de0cff" :slant italic :weight bold)))
  "primitive type")
(defface shkw-modifier-color
  '((t (:foreground "#fa00ff" :slant italic :weight bold)))
  "modifier")
(defface shkw-operators-color
  '((t (:foreground "#ffb600" :weight bold)))
  "operators")
(defface shkw-pointers-color
  '((t (:foreground "#00e9ff" :weight bold)))
  "pointers")
(defface shkw-sentence-color
  '((t (:foreground "#b3afff" :slant italic :weight bold)))
  "sentence")
(defface shkw-define-color
  '((t (:foreground "#00ff19" :slant italic :weight bold)))
  "define")

;; ==== ==== ==== Map ==== ==== ==== ;;
(define-generic-mode shkw-c-mode
  '("//"
    ("/*" . "*/"))
  '()
  '(("\\(\+\\|\-\\|\*\\|\/\\|\%\\|\=\\|;\\)"
     (1 'shkw-operators-color t))
    ("\\(if\\|else\\|for\\|while\\|do\\|switch\\|case\\|default\\|continue\\|break\\|goto\\|return\\)\\>"
     (1 'shkw-sentence-color t))
    ("\\(\\(char\\|int\\|float\\|double\\|struct\\|enum\\|void\\)\\(\**\\)?\\)\\>"
     (1 'shkw-primitive-type-color t))
    ("\\(static\\|auto\\|const\\|short\\|long\\|signed\\|unsigned\\|typedef\\|extern\\)\\>"
     (1 'shkw-modifier-color t))
    ("\\(->\\|\\\.\\)"
     (1 'shkw-pointers-color t))
    ("\\(#\\(define\\|if\\|ifn\\|else\\|ifdef\\|ifndef\\|include\\)\\)\\>"
     (1 'shkw-define-color t)))
  '(".+\\.\\(c\\|h\\|cpp\\|hpp\\)")
  '((lambda ()
      (progn
	(use-local-map shkw-c-mode-map)
	(setq mode-name "shkw-C"))))
  "shkw-C")

;; ==== ==== ==== Functions ==== ==== ==== ;;
;; [ToDo] add type checker
