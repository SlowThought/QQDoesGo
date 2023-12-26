#lang typed/racket
;; go-game-state.rkt by Patrick King. Gnu Library License 3+
;; get and set current game state, make-move, undo-move, at least in theory

;; For now, most primitive representation I can imagine. I do bad things. When I fix them, I can remove
;; this comment.
(require math/array)
(provide (all-defined-out))

;; Variables are pointers, easily compared? Underlying symbols meant to be helpful in debugging
(define eni 'error-not-initialized)
(define undef 'undefined)
(define ws 'white-stone)
(define bs 'black-stone)
(define dm 'dame)
(define em 'empty)
(define wt 'white-territory)
(define bt 'black-territory)

;; Points are pairs of unsigned integers
(struct pt [(x : Positive-Byte)
            (y : Positive-Byte)])

;; The goban -- array & list representations
(struct goban
  [(m : Positive-Byte)       ; length of board
   (n : Positive-Byte)       ; width  of board
   (board : (Arrayof any))   ; 2-d array of ??
   (white-stones : List)     ;list of lists of points, each list a contiguous region
   (black-stones : List)     ;list of ...
   (dame : List)             ;list of ...
   (white-territory : List)  ;list of ...
   (black-territory : List)]);list of ...
  

;;; Constructors/Initializers
;(define (reset-board-data n)
;  ; Points are represented by vectors #(x y)
;  (set! empty-pts(for*/list [(x (in-range n))
;                             (y (in-range n))]
;                   (vector x y)))
;  (set! black-pts empty)
;  (set! white-pts empty)
;  (set! to-move 'black)
;  (set! board-size n))
;
;;; Make a move
;;; Early days, no capturing
;(define (make-move m)
;  (if (eqv? m 'pass)
;      (set! to-move (if (eqv? to-move 'black) 'white 'black))
;      (if (not (member m empty-pts))
;          'err-not-an-available-point
;          (begin
;            (set! empty-pts (remove m empty-pts))
;            (if (eqv? to-move 'black)
;                (begin
;                  (set! black-pts (cons m black-pts))
;                  (set! to-move 'white))
;                (begin
;                  (set! white-pts (cons m white-pts))
;                  (set! to-move 'black)))))))
;        
;
;  