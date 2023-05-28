(in-package :cepl-start)

(defun frameless-repl (&optional (width 640) (height 480))
  "Create frameless surface."
  (initialize-cepl)
  (cepl.context:add-surface (cepl-context)
                            :no-frame t
                            :resizable nil
                            :make-current t))

(defun win-resize (&optional (w 640) (h 480) (x 0) (y 0))
  "Adjust size and position of window."
  (let* ((win (current-surface)))
    (sdl2:set-window-size win w h)
    (sdl2:set-window-position win x y)
    (setf (resolution (current-viewport)) (v! (list w h)))
    (current-viewport)))

(defun use-full-screen (&optional (display (sdl2:get-num-video-displays)))
  "Use full screen of last or chosen display."
  (let* ((rect (sdl2:get-display-bounds display))
         (x (sdl2:rect-x rect))
         (y (sdl2:rect-y rect))
         (w (sdl2:rect-width rect))
         (h (sdl2:rect-height rect)))
    (win-resize w h x y)))

(defun init ()
  "Create surface.
Use full screen on second display if we have more than one."
  (unless (surfaces)
    (frameless-repl))
  (if (< 1 (sdl2:get-num-video-displays))
      (use-full-screen 1)
      (win-resize 640 480 0 0)))
