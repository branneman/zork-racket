#lang racket

(require graph)

(provide leveldata
         leveldata-label
         leveldata-label-set!
         leveldata-description
         graph-part)

(define leveldata (unweighted-graph/undirected '()))

(define-vertex-property leveldata leveldata-label)
(define-vertex-property leveldata leveldata-description)
(define-edge-property leveldata leveldata-edge-direction)

; adds a vertex, edges and metadata
(define (graph-part vertex label desc edges)
  (leveldata-label-set! vertex label)
  (leveldata-description-set! vertex desc)
  (for/list ([edge edges])
    (define-values (dir vertex2) (apply values edge)) ; very verbose destructure?!
    (add-edge! leveldata vertex vertex2)
    (leveldata-edge-direction-set! vertex vertex2 dir))
  (void))
