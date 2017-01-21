;;; shkw.el
;; Copyright (C) 2016

;; Author: shinkwhek
;; Keywords:
(provide 'shkw)

;; ==== ==== ==== Requuire package ==== ==== ==== ;;
(eval-when-compile (require 'cl))

;; ==== ==== ==== Tiny ==== ==== ==== ;;
(defmacro thereis-obj-in-list (obj lst)
  `(loop for elm in ,lst thereis (string= ,obj elm)))

;; ==== ==== ==== Insert line ==== ==== ==== ;;
(defun shkw-insert-title-line (agTitle)
  (interactive "sTitle: ")
  (insert
   (let ((bf (file-name-extension (buffer-file-name))))
     (cond
      ((thereis-obj-in-list bf '("v"))
       (format "(* ==== ==== ==== %s ==== ==== ==== *)\n" agTitle))
      ((thereis-obj-in-list bf '("el" "lisp"))
       (format ";; ==== ==== ==== %s ==== ==== ==== ;;\n" agTitle))
      ((thereis-obj-in-list bf '("c" "h" "cpp" "hpp"))
       (format "/* ==== ==== ==== %s ==== ==== ==== */\n" agTitle))
      ((thereis-obj-in-list bf '("ml" "mli"))
       (format "(* ==== ==== ==== %s ==== ==== ==== *)\n" agTitle))
      ((thereis-obj-in-list bf '("sml"))
       (format "(* ==== ==== ==== %s ==== ==== ==== *)\n" agTitle))
      ((thereis-obj-in-list bf '("tex" "sty" "ltx"))
       (format "%% ==== ==== ==== %s ==== ==== ==== %%\n" agTitle))))))
  
(defun shkw-insert-subtitle-line (agSubTitle)
  (interactive "sSubTitle: ")
  (insert
   (let ((bf (file-name-extension (buffer-file-name))))
     (cond
      ((thereis-obj-in-list bf '("v"))
       (format "(* ---- ---- %s ---- ---- *)\n" sgSubTitle))
      ((thereis-obj-in-list bf '("el" "lisp"))
       (format ";; ---- ---- %s ---- ---- ;;\n" agSubTitle))
      ((thereis-obj-in-list bf '("c" "h" "cpp" "hpp"))
       (format "/* ---- ---- %s ---- ---- */\n" agSubTitle))
      ((thereis-obj-in-list bf '("ml" "mli"))
       (format "(* ---- ---- %s ---- ---- *)\n" agSubTitle))
      ((thereis-obj-in-list bf '("sml"))
       (format "(* ---- ---- %s ---- ---- *)\n" agSubTitle))
      ((thereis-obj-in-list bf '("tex" "sty" "ltx"))
       (format "%% ---- ---- %s ---- ---- %%\n" agSubTitle))))))

;; ==== ==== ==== Tools ==== ==== ==== ;;
(defun shkw-insert-today ()
  (interactive)
  (let ((today (current-time)))
    (insert (format-time-string "%D" today))))
