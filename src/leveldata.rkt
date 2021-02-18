#lang racket

(require graph)

; player state
(provide movements
         add-movement
         get-location
         has-visited
         set-visited)

(define movements '(west-of-house)) ; reversed
(define (add-movement location)
  (set! movements (cons location movements)))
(define (get-location) (first movements))

; game data
(provide leveldata
         leveldata-label
         leveldata-label-set!
         leveldata-description)

(define leveldata (unweighted-graph/undirected '()))

(define-vertex-property leveldata leveldata-label)
(define-vertex-property leveldata leveldata-description)
(define-edge-property leveldata leveldata-edge-direction)

(define-vertex-property leveldata leveldata-visited #:init #f)
(define (has-visited location) (leveldata-visited location #:default #f))
(define (set-visited location) (leveldata-visited-set! location #t))

; adds a vertexes, edges and metadata
(define (graph-part vertex label desc edges)
  (leveldata-label-set! vertex label)
  (leveldata-description-set! vertex desc)
  (for/list ([edge edges])
    (define-values (dir vertex2) (apply values edge)) ; very verbose destructure?!
    (add-edge! leveldata vertex vertex2)
    (leveldata-edge-direction-set! vertex vertex2 dir))
  (void))

(graph-part 'west-of-house "West of House"
  "You are standing in an open field west of a white house, with a boarded front door."
  '((N north-of-house)
    (S south-of-house)
    ;(SW stone-barrow)
    (W forest-1)))

(graph-part 'north-of-house "North of House"
  "You are facing the north side of a white house. There is no door here, and all the windows are boarded up. To the north a narrow path winds through the trees."
  '((W west-of-house)
    (N forest-path)
    (E behind-house)))

(graph-part 'behind-house "Behind House"
  ; "slightly ajar" vs "open"
  "You are behind the white house. A path leads into the forest to the east. In one corner of the house there is a small window which is slightly ajar."
  '((N north-of-house)
    ;(E clearing-2)
    (S south-of-house)))

(graph-part 'south-of-house "South of House"
  "You are facing the south side of a white house. There is no door here, and all the windows are boarded."
  '((W west-of-house)
    (E behind-house)
    (S forest-3)))

(graph-part 'forest-path "Forest Path"
  "This is a path winding through a dimly lit forest. The path heads north-south here. One particularly large tree with some low branches stands at the edge of the path."
  '((S north-of-house)
    (W forest-1)))

(graph-part 'forest-1 "Forest"
  "This is a dimly lit forest, with large trees all around." ; + random forest sentence
  '((S forest-3)
    ;(N clearing-1)
    (E forest-path)))

(graph-part 'forest-3 "Forest"
  "This is a dimly lit forest, with large trees all around." ; + random forest sentence
  '((NW south-of-house)
    ;(N clearing-2)
    (W forest-1)))
