#lang racket

(require graph)
(require "leveldata.rkt")

(provide movements
         add-movement
         get-location
         has-visited
         set-visited)

(define movements '(west-of-house)) ; reversed
(define (add-movement location)
  (set! movements (cons location movements)))
(define (get-location) (first movements))

(define-vertex-property leveldata leveldata-visited #:init #f)
(define (has-visited location) (leveldata-visited location #:default #f))
(define (set-visited location) (leveldata-visited-set! location #t))
