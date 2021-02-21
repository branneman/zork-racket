#lang racket

(require graph)
(require "leveldata.rkt")
(require "strings.rkt")

(provide command
         command-id
         command-variables
         state/update
         state/commands
         state/add-command
         state/get-location
         state/has-visited
         state/set-visited
         state/get-score
         state/get-rank)

(struct command (id variables) #:transparent)

(define state/commands '())
(define (state/add-command cmd)
  (set! state/commands (cons cmd state/commands)))

; iterate over state/commands to retrieve current location
(define (state/get-location)
  'west-of-house)

(define-vertex-property leveldata leveldata-visited #:init #f)
(define (state/has-visited location) (leveldata-visited location #:default #f))
(define (state/set-visited location) (leveldata-visited-set! location #t))

(define state/max-score 350)
(define (state/get-score)
  0)

(define (state/get-rank score)
  (cond
    [(< score 25) "Beginner"]
    [(< score 50) "Amateur Adventurer"]
    [(< score 100) "Novice Adventurer"]
    [(< score 200) "Junior Adventurer"]
    [(< score 300) "Adventurer"]
    [(< score 330) "Master"]
    [(< score 350) "Wizard"]
    [(= score 350) "Master Adventurer"]
    [else "Cheater"]))

; state/update :: command<id,variables> -> (string ...)
(define (state/update cmd)
  (case (command-id cmd)
    ['score
      (list
        ((compose1 (λ (s) (string-replace s "$1" (format "~a" (state/get-score))))
                   (λ (s) (string-replace s "$2" (format "~a" state/max-score)))
                   (λ (s) (string-replace s "$3" (format "~a" (length state/commands)))))
          (get-string 'score)))]

    ['rank
      (list (string-replace
        (get-string 'rank)
        "$1"
        (format "~a" (state/get-rank (state/get-score)))))]

    ['quit
      (begin
        (display (string-append (first (state/update (command 'score '()))) "\n"))
        (display (string-append (first (state/update (command 'rank '()))) "\n"))
        (exit))]

    ['error
      (list (get-string (first (command-variables cmd))))]
    
    [else
      (error "state/update: unknown command")]))
