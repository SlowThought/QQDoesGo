#lang racket/gui
;; goui-top.rkt by Patrick King. Gnu Library License 3+
;; Instantiates the top window, menu, and (management of the) board window.

; QQ - rank of new go players, and classic Star Wars Storm Trooper missing yet again sound.
(define top-frame (new frame% [label "Kew Kew"]))


; Make a static text message in the frame
(define msg (new message% [parent top-frame]
                          [label "No events so far..."]))


 
; Make a canvas that handles events in the frame
(require "goui-board.rkt")
(new board-canvas% [parent top-frame])

; Execute
(send top-frame show #t)