#lang racket

(require "state.rkt")

(provide parser/parse
         parser/clean-input
         parser/words->command)

; parser/parse :: string -> command<id,variables>
(define (parser/parse input)
  (let* ([cleaned (parser/clean-input input)]
         [words (string-split cleaned " ")])
    (parser/words->command words)))

; parser/clean-input :: string -> string
(define parser/clean-input
  (compose1 string-downcase
            string-trim
            (λ (s) (string-replace s #px"\\s+" " "))
            (λ (s) (string-replace s #px"[^a-zA-Z\\s]" ""))))

; parser/words->command :: (string ...) -> command<id,variables>
(define (parser/words->command words)
  (define sentence-length (length words))
  (define unknown-sentence (command 'error '(input-unknown-sentence)))
  (cond

    [(> sentence-length 2)
     unknown-sentence]

    [(= sentence-length 2)
     (cond
       [(equal? words '("look" "around"))
        (command 'look '())]
       [(or (equal? (first words) "move")
            (equal? (first words) "go"))
        (let* ([word (second words)]
               [dir (cond
                      [(equal? word "up") 'up]
                      [(equal? word "down") 'down]
                      [(equal? word "north") 'N]
                      [(equal? word "northeast") 'NE]
                      [(equal? word "east") 'E]
                      [(equal? word "southeast") 'SE]
                      [(equal? word "south") 'S]
                      [(equal? word "southwest") 'SW]
                      [(equal? word "west") 'W]
                      [(equal? word "northwest") 'NW])])
          (if (not (void? dir))
              (command 'move (list dir))
              (unknown-sentence)))]
       [else unknown-sentence])]

    [(= sentence-length 1)
     (cond
       [(equal? (first words) "look")
        (command 'look '())]
       [(equal? (first words) "score")
        (command 'score '())]
       [(equal? (first words) "rank")
        (command 'rank '())]
       [(or (equal? (first words) "quit")
            (equal? (first words) "exit"))
        (command 'quit '())]
       [else unknown-sentence])]

    [(= sentence-length 0)
     (command 'error '(input-empty))]

    [else
     unknown-sentence]))
