#lang racket
(require pict3d "Quaternion.rkt")


;;; Utilities
(define (Q->P q) ; We assume that the real part is irrelavant -- this is SO close to
                 ; (vector-part q) -- design issue?
  (pos (imag-part q)
       (jmag-part q)
       (kmag-part q)))

;;; Primitive images

(define (display-cell location color radius)
  (let [(loc (Q->P location))]
    (parameterize [(current-color  (rgba color))]
    (sphere loc radius))))

;;; Test case

(display-cell (Quaternion 0 1 2 3) "light blue" 1/2)
