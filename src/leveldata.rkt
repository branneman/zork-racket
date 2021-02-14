#lang racket

(require graph)

; player state
(provide movements
         add-movement
         get-location
         has-visited
         set-visited)

; game data
(provide leveldata
         leveldata-label
         leveldata-label-set!
         leveldata-description)

(define movements '(west-of-house)) ; reversed
(define (add-movement location)
  (set! movements (cons location movements)))
(define (get-location) (first movements))

(define leveldata (unweighted-graph/undirected '()))

(define-vertex-property leveldata leveldata-label)
(define-vertex-property leveldata leveldata-description)

(define-vertex-property leveldata leveldata-visited #:init #f)
(define (has-visited location) (leveldata-visited location #:default #f))
(define (set-visited location) (leveldata-visited-set! location #t))

;(get-vertices leveldata)
;(get-neighbors leveldata 'west-of-house)

; West of House
(leveldata-label-set! 'west-of-house "West of House")
(leveldata-description-set! 'west-of-house "You are standing in an open field west of a white house, with a boarded front door.\nThere is a small mailbox here.")
(add-edge! leveldata 'west-of-house 'north-of-house)
(add-edge! leveldata 'west-of-house 'south-of-house)
(add-edge! leveldata 'west-of-house 'stone-barrow)
(add-edge! leveldata 'west-of-house 'forest-1)

;(has-visited 'kitchen)
;(set-visited 'kitchen)

;(leveldata-label 'west-of-house)
;(leveldata-description 'west-of-house)
