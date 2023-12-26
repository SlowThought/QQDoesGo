#lang slideshow
;; goui.rkt by Patrick King. Gnu Library License 3+
(define default-size 50)
(define board-bg (filled-rectangle default-size default-size
                                   #:draw-border? #false
                                   #:color "Goldenrod"))

; Occupied points
(define black-pt (cc-superimpose board-bg (disk default-size #:color "Black" #:border-color "White")))
(define white-pt (cc-superimpose board-bg (disk default-size #:color "White" #:border-color "Black")))

; Interior Points
(define interior-pt (cc-superimpose board-bg (hline default-size default-size)(vline default-size default-size)))
(define star-pt (cc-superimpose interior-pt (disk 8)))

; Corner points
(define ne-pt (cb-superimpose (lc-superimpose board-bg (hline (/ default-size 2) default-size))
                              (vline default-size (/ default-size 2))))
(define nw-pt (rotate ne-pt (/ pi 2)))
(define sw-pt (rotate nw-pt (/ pi 2)))
(define se-pt (rotate sw-pt (/ pi 2)))

; Side points
(define n-pt (cb-superimpose (cc-superimpose board-bg (hline default-size default-size))
                             (vline default-size (/ default-size 2))))
(define w-pt (rotate n-pt (/ pi 2)))
(define s-pt (rotate w-pt (/ pi 2)))
(define e-pt (rotate s-pt (/ pi 2)))

; Test our rendering - a 5x5 board to include all point types. Good derivative types imply good root types, so we'll put our
; stones in the upper right.
(vc-append (hc-append nw-pt n-pt n-pt black-pt white-pt)
           (hc-append w-pt interior-pt interior-pt interior-pt e-pt)
           (hc-append w-pt interior-pt star-pt interior-pt e-pt)
           (hc-append w-pt interior-pt interior-pt interior-pt e-pt)
           (hc-append sw-pt s-pt s-pt s-pt se-pt))

; Render a point on the board - by render, I mean return appropriate pict
(define (render-pt x y v n)
  ; x, y coordinates
  ; v value -1 = Black, 0 = empty, +1 = White
  ; n board size
  (let [(n-1 (sub1 n))]
    (cond [(= v 1)  white-pt]
          [(= v -1) black-pt]
          ; v = 0 -- some kind of empty point
          [(= x 0) ; left edge
           (cond [(= y 0) nw-pt]
                 [(= y n-1) sw-pt]
                 [#t w-pt])]
          [(= y 0) ; top edge, excluding nw point
           (if (= x n-1) ne-pt n-pt)]
          [(= y n-1) ; bottom edge, excluding sw point
           (if (= x n-1) se-pt s-pt)]
          [(= x n-1) e-pt] ; eastern corners already covered
          ; Only interior points remain. Identify 9 star points
          [#t interior-pt]))) ; for now, we punt