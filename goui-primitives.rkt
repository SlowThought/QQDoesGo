#lang slideshow
;; goui-primitives.rkt by Patrick King. Gnu Library License 3+
;; uses picts to draw points & stones
;; exports (render-pt x y v n), and (render-board board . move)
;; TO DO: place star points based on x y and n
;;        (nice to have) (get/set background colour to eliminate the pale white lines between points

(provide render-pt render-board)

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

;; Test our rendering - a 5x5 board to include all point types. Good derivative types imply good root types,
;; so we'll put our stones in the upper right.
;(module+ test
;  (vc-append (hc-append nw-pt n-pt n-pt black-pt white-pt)
;             (hc-append w-pt interior-pt interior-pt interior-pt e-pt)
;             (hc-append w-pt interior-pt star-pt interior-pt e-pt)
;             (hc-append w-pt interior-pt interior-pt interior-pt e-pt)
;             (hc-append sw-pt s-pt s-pt s-pt se-pt)))

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
          [(and (> n 2)(odd? n)(= x (quotient n 2))(= y (quotient n 2)) star-pt)]
          [#t interior-pt]))) ; for now, we punt

(define (render-board b)
  (define n (vector-length b))
  (apply vc-append
         (for/list ((y (in-range n)))
           (apply hc-append
                  (for/list ((x (in-range n)))
                    (render-pt x y (vector-ref (vector-ref b y) x) n))))))
  

(define (place-stone! b to-move x y)
  (vector-set! (vector-ref b y) x
               (cond ((eqv? to-move 'black) -1)
                     ((eqv? to-move 'white)  1)
                     (else (error "place-stone fed value other than 'black or 'white to move")))))

(define (new-board n)
  (build-vector n (λ (i) (make-vector n))))

(define (copy-board-with-move b to-move x y)
  (define c (vector-copy b))
  (place-stone! c to-move x y)
  c)

(define b1 (new-board 3))

(render-board b1)

(place-stone! b1 'black 2 1)
(place-stone! b1 'white 1 1)

(define b2 (copy-board-with-move b1 'black 0 0))

(render-board b2)


