#lang racket

(require graph)

(provide leveldata
         leveldata-label
         leveldata-description
         leveldata-visited?)

(define leveldata (unweighted-graph/undirected '()))
(define-vertex-property leveldata leveldata-label)
(define-vertex-property leveldata leveldata-description)
(define-vertex-property leveldata leveldata-visited? #:init #f)

;(get-vertices leveldata)
;(get-neighbors leveldata 'west-of-house)

; West of House
(leveldata-label-set! 'west-of-house "West of House")
(leveldata-description-set! 'west-of-house "You are standing in an open field west of a white house, with a boarded front door.\nThere is a small mailbox here.")
(add-edge! leveldata 'west-of-house 'north-of-house)
(add-edge! leveldata 'west-of-house 'south-of-house)
(add-edge! leveldata 'west-of-house 'stone-barrow)
(add-edge! leveldata 'west-of-house 'forest-1)

;(leveldata-visited?-set! 'kitchen #t)
;(leveldata-visited? 'kitchen)

;(leveldata-label 'west-of-house)
;(leveldata-description 'west-of-house)
