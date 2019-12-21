(require 'gamegrid)

(defconst xmas-tree-buffer-name "*XMASTREE*")

(defconst xmas-tree--display-padding-top 5)
(defconst xmas-tree--display-padding-left 3)
(defvar xmas-tree--display-width)
(defvar xmas-tree--display-height)

(defvar xmas-tree--leafs nil)
(defvar xmas-tree--stems nil)
(defvar xmas-tree--snows nil)

(defvar xmas-tree--leaf-height 15)
(defvar xmas-tree--stem-height 2)
(defun xmas-tree--height ()
    (+ xmas-tree--leaf-height xmas-tree--stem-height))

;;------------------------------
;; Glyph and Ascii options
;;------------------------------

(defconst xmas-tree--display-blank 0)
(defconst xmas-tree--display-leaf 1)
(defconst xmas-tree--display-snow 2)
(defconst xmas-tree--display-stem 3)

(defconst xmas-tree--display-blank-options
    '(
         ((glyph colorize)
             (t ? ))

         ((color-x color-x)
             (color-tty color-tty)
             (t mono-tty))

         (((glyph color-x) [0 0 0])
             (color-tty "black"))))

(defconst xmas-tree--display-leaf-options
  '(
    ((glyph colorize)
     (t ?*))

    ((color-x color-x)
     (color-tty color-tty)
     (t mono-tty))

    (((glyph color-x) [0 1 0])
     (color-tty "green"))))

(defconst xmas-tree--display-snow-options
  '(
    ((glyph colorize)
     (t ?O))

    ((color-x color-x)
     (color-tty color-tty)
     (t mono-tty))

    (((glyph color-x) [1 1 1])
     (color-tty "white"))))


(defconst xmas-tree--display-stem-options
  '(
    ((glyph colorize)
     (t ?M))

    ((color-x color-x)
     (color-tty color-tty)
     (t mono-tty))

    (((glyph color-x) [0.7 0.3 0.1])
     (color-tty "brown"))))

(defun xmas-tree--display-options ()
  (let ((options (make-vector 256 '(nil nil nil))))
    (aset options xmas-tree--display-blank xmas-tree--display-blank-options)
    (aset options xmas-tree--display-leaf xmas-tree--display-leaf-options)
    (aset options xmas-tree--display-snow xmas-tree--display-snow-options)
    (aset options xmas-tree--display-stem xmas-tree--display-stem-options)
    options))

;;------------------------------
;; Stem struct
;;------------------------------

(defstruct xmas-tree--stem
  (x 0) (y 0))

(defun xmas-tree--stem:show (stem)
  (gamegrid-set-cell (xmas-tree--stem-x stem) (xmas-tree--stem-y stem) xmas-tree--display-stem))

(defun xmas-tree--stem:planting ()
  (let* ((height xmas-tree--stem-height)
         (width (1+ (/ xmas-tree--leaf-height 4)))
         (parts (make-vector (* height width) nil))
         (index 0)
         y x)
    (dotimes (h height)
      (setq y (- xmas-tree--display-height h 1))
      (dotimes (x width)
        (aset parts
              index
              (make-xmas-tree--stem :x (- xmas-tree--display-width x 1)
                                    :y y))
        (incf index)))
    parts))

;;------------------------------
;; Leaf struct
;;------------------------------

(defstruct xmas-tree--leaf
    (x 0) (y 0))

(defun xmas-tree--leaf:show (leaf)
    (gamegrid-set-cell (xmas-tree--leaf-x leaf) (xmas-tree--leaf-y leaf) xmas-tree--display-leaf))

(defun xmas-tree--leaf:planting ()
    (let* ((height xmas-tree--leaf-height)
              (width height)
              (parts (make-vector (/ (* height (1+ height)) 2) nil))
              (index 0)
              padding-num leaf-num)
        (dotimes (y height)
            (setq leaf-num (1+ y))
            (setq padding-num (- width leaf-num))

            (dotimes (x leaf-num)
                (aset parts
                    index
                    (make-xmas-tree--leaf :x (+ x padding-num xmas-tree--display-padding-left)
                        :y (+ y xmas-tree--display-padding-top)))
                (incf index)))
        parts))

;;------------------------------
;; Snow struct
;;------------------------------

(defstruct xmas-tree--snow
    (x 0) (y 0))

(defun xmas-tree--snow:show (snow)
    (gamegrid-set-cell (xmas-tree--snow-x snow) (xmas-tree--snow-y snow) xmas-tree--display-snow))

(defun xmas-tree--snow:add ()
    (interactive)
    (let ((snow (make-xmas-tree--snow :x (random xmas-tree--display-width) :y 0)))
        (setq xmas-tree--snows (append xmas-tree--snows (list snow)))))

(defun xmas-tree--snow:down (snow)
    (incf (xmas-tree--snow-y snow)))

(defun xmas-tree--snow:out-of-frame-p (snow)
    (>= (xmas-tree--snow-y snow) xmas-tree--display-height))


;;------------------------------
;; Drawing functions
;;------------------------------

(defun xmas-tree--update-background ()
    (dotimes (y xmas-tree--display-height)
        (dotimes (x xmas-tree--display-width)
            (gamegrid-set-cell x y xmas-tree--display-blank))))

(defun xmas-tree--update-tree()
    (mapc 'xmas-tree--leaf:show xmas-tree--leafs)
    (mapc 'xmas-tree--stem:show xmas-tree--stems))

(defun xmas-tree--update-snows()
    (mapc 'xmas-tree--snow:down xmas-tree--snows)
    (setq xmas-tree--snows
        (loop for s in xmas-tree--snows
            unless (xmas-tree--snow:out-of-frame-p s)
            collect s))
    (mapc 'xmas-tree--snow:show xmas-tree--snows))

;;------------------------------
;; Main routine
;;------------------------------

(setq xmas-tree-mode-map
    (let ((map (make-sparse-keymap 'xmas-tree-mode-map)))
        (define-key map (kbd "SPC") 'xmas-tree--snow:add)
        (define-key map (kbd "q") 'xmas-tree-end)
        map))

(defun xmas-tree--update (xmas-tree-buffer)
    (when (eq (current-buffer) xmas-tree-buffer)
        (xmas-tree--update-background)
        (xmas-tree--update-tree)
        (xmas-tree--update-snows)))

(defun xmas-tree-end ()
    (interactive)
    (gamegrid-kill-timer)
    (kill-buffer xmas-tree-buffer-name))

(defun xmas-tree-init ()
    (setq xmas-tree--display-height (+ (xmas-tree--height)
                                        xmas-tree--display-padding-top))

    (setq xmas-tree--display-width (+ xmas-tree--leaf-height ;; leaf height = width
                                       xmas-tree--display-padding-left))

    (setq xmas-tree--snows nil)
    (setq xmas-tree--leafs (xmas-tree--leaf:planting))
    (setq xmas-tree--stems (xmas-tree--stem:planting))

    (gamegrid-init-buffer xmas-tree--display-width xmas-tree--display-height ? )
    (gamegrid-init (xmas-tree--display-options)))

(define-derived-mode xmas-tree-mode nil "X'mas Tree"
    (use-local-map xmas-tree-mode-map)
    (add-hook 'kill-buffer-hook 'gamegrid-kill-timer nil t)

    (gamegrid-kill-timer)
    (xmas-tree-init)
    (gamegrid-start-timer 0.1 'xmas-tree--update))

(defun xmas-tree ()
    "xmas-tree-mode keybindings:
\\{xmas-tree-mode-map}"
    (interactive)
    (select-window (or (get-buffer-window xmas-tree-buffer-name)
                       (selected-window)))
    (switch-to-buffer xmas-tree-buffer-name)
    (xmas-tree-mode))
