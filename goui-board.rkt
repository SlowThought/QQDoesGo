#lang racket/gui
;; goui-board.rkt by Patrick King. Gnu Library License 3+
;; Instantiates the board window. Handles cursor appearance, mouse events. Requires knowledge of
;; board representation.
(require "goui-primitives.rkt"
         "go-game-state.rkt")
#| Rough plan of gui:
   top-frame -----> top-menu
             -----> board-frame (instance of square-frame%), news-frame (instance of console-frame%?)

|#
            

(define top-frame (new frame% [label "Kew Kew Go"]))

(define menu-bar (new menu-bar% (parent top-frame)))

(define file-menu (new menu%
                       (parent menu-bar)
                       (label "File")))

(define help-menu (new menu%
                       (parent menu-bar)
                       (label "Help")))

(new menu-item% (parent help-menu)
                (label "About")
                (callback (new dialog%
                               (label "About Kew Kew Go")
                               (parent top-frame)
                               
                               
     
;(define square-canvas%
 ; (class canvas%



(send top-frame show #t)

