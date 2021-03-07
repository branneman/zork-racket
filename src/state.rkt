#lang racket

(require graph
         "leveldata.rkt"
         "strings.rkt")

(provide command
         command-id
         command-variables
         state/update
         state/commands
         state/add-command
         state/get-location
         state/set-location
         state/has-visited
         state/set-visited
         state/get-score
         state/get-rank)

(struct command (id variables) #:transparent)

; commands
(define state/commands '())
(define (state/add-command cmd)
  (set! state/commands (cons cmd state/commands)))
(define (state/reset-commands)
  (set! state/commands '()))

; location
(define state/location 'west-of-house)
(define (state/get-location) state/location)
(define (state/set-location loc)
  (set! state/location loc))
(define (state/reset-location)
  (set! state/location 'west-of-house))

; health
(define state/health-max 5)
(define state/health state/health-max)
(define (state/is-dead) (<= state/health 0))
(define (state/health-decrease)
  (if (state/is-dead)
      (void)
      (set! state/health (- state/health 1))))
(define (state/health-increase)
  (if (= state/health state/health-max)
      (void)
      (set! state/health (+ state/health 1))))
(define (state/reset-health)
  (set! state/health state/health-max))

; visited
(define-vertex-property leveldata leveldata-visited #:init #f)
(define (state/has-visited loc) (leveldata-visited loc #:default #f))
(define (state/set-visited loc) (leveldata-visited-set! loc #t))
(define (state/reset-visited)
  (for ([loc (level/get-locations)])
    (leveldata-visited-set! loc #f)))

(define state/max-score 350)
(define (state/get-score) 0)

; state/get-rank :: number -> string
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
  (state/add-command cmd)
  (case (command-id cmd)
    ['look
     (let ([loc (state/get-location)])
       (state/set-visited loc)
       (list (leveldata-label loc)
             (leveldata-description loc)))]

    ['move
     (let* ([dir (first (command-variables cmd))]
            [edges (level/get-edges (state/get-location))]
            [edge (findf (λ (edge) (equal? dir (first edge)))
                         edges)]
            [new-loc (if (false? edge) #f (second edge))])
       (if (false? new-loc)
           (list (get-string 'input-direction-wrong))
           (begin
             (state/set-location new-loc)
             (if (state/has-visited (state/get-location))
                 (list (leveldata-label new-loc))
                 (begin
                   (state/set-visited new-loc)
                   (list (leveldata-label new-loc)
                         (leveldata-description new-loc)))))))]

    ['diagnose
     (list (get-string (string->symbol (string-append "health-" (~s state/health)))))]

    ['shout
     (list (get-string 'shout))]

    ['score
     (list
      ((compose1 (λ (s) (string-replace s "$1" (~s (state/get-score))))
                 (λ (s) (string-replace s "$2" (~s state/max-score)))
                 (λ (s) (string-replace s "$3" (~s (length state/commands)))))
       (get-string 'score)))]

    ['rank
     (list (string-replace
            (get-string 'rank)
            "$1"
            (~s (state/get-rank (state/get-score)))))]

    ['restart
     (begin
       (state/reset-commands)
       (state/reset-location)
       (state/reset-visited)
       (state/reset-health)
       (let ([loc (state/get-location)])
         (state/set-visited loc)
         (list (leveldata-label loc)
               (leveldata-description loc))))]

    ['quit
     (begin
       (display (string-append (first (state/update (command 'score '()))) "\n"))
       (display (string-append (first (state/update (command 'rank '()))) "\n"))
       (exit))]

    ['error
     (list (get-string (first (command-variables cmd))))]
    
    [else
     (error "state/update: unknown command")]))
