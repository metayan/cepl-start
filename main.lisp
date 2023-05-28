(in-package :cepl-start)

(defun-g simple-vert ((position :vec4))
  (values position
          (v! (x position) (y position))))

(defun-g time-frag ((posxy :vec2) &uniform (time :float))
  (let* ((p (* (v! 1.6 1.0) posxy))
         (ti (mod (* -15 time) 2pi-f))
         (l (* 40 (length p)))
         (a (+ (- (atan (x p) (y p)) l) ti))
         (r (sin a))
         (g (sin (+ a 2)))
         (b (* 0.5 (sin (+ a 4)))))
    (v4! r g b 1)))

(defpipeline-g time-pipe ()
  (simple-vert :vec4)
  (time-frag :vec2))

;; -------------------------------------------------------

(defvar *gpu-array* nil)
(defvar *vertex-stream* nil)

(defun now ()
  "Float seconds."
  (/ (get-internal-real-time)
     (coerce internal-time-units-per-second 'single-float)))

(defun draw ()
  (step-host)
  (update-repl-link)
  (clear)
  (map-g #'time-pipe *vertex-stream* :time (now))
  (swap))

(let ((running nil))
  (init)
  (defun run-loop ()
    (setf *gpu-array*
          (make-gpu-array (list (v! -1.0  -1.0  0.0  1.0)
                                (v!  1.0  -1.0  0.0  1.0)
                                (v!  1.0   1.0  0.0  1.0)
                                (v!  1.0   1.0  0.0  1.0)
                                (v! -1.0   1.0  0.0  1.0)
                                (v! -1.0  -1.0  0.0  1.0))
                          :element-type :vec4
                          :dimensions 6))
    (setf *vertex-stream* (make-buffer-stream *gpu-array*))
    (setf running t)
    (loop :while (and running (not (shutting-down-p))) :do
          (continuable (draw))))
  (defun stop-loop () (setf running nil)))

(run-loop)
