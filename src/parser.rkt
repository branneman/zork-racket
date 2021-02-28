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

; parser/replace-aliases :: (string ...) -> (string ...)
(define (parser/replace-aliases words)
  (map (λ (x) x)
       words))

; parser/words->command :: (string ...) -> command<id,variables>
(define (parser/words->command words)
  (let* ([sentence-length (length words)]
         [unknown-sentence (command 'error '(input-unknown-sentence))]
         [words (parser/replace-aliases words)])
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
                      [(or (equal? word "up")        (equal? word "u"))  'up]
                      [(or (equal? word "down")      (equal? word "d"))  'down]
                      [(or (equal? word "north")     (equal? word "n"))  'N]
                      [(or (equal? word "northeast") (equal? word "ne")) 'NE]
                      [(or (equal? word "east")      (equal? word "e"))  'E]
                      [(or (equal? word "southeast") (equal? word "se")) 'SE]
                      [(or (equal? word "south")     (equal? word "s"))  'S]
                      [(or (equal? word "southwest") (equal? word "sw")) 'SW]
                      [(or (equal? word "west")      (equal? word "w"))  'W]
                      [(or (equal? word "northwest") (equal? word "nw")) 'NW])])
          (if (not (void? dir))
              (command 'move (list dir))
              (unknown-sentence)))]
       [else unknown-sentence])]

    [(= sentence-length 1)
     (let ([word (first words)])
       (cond
         [(or (equal? word "up")        (equal? word "u"))  (command 'move '(up))]
         [(or (equal? word "down")      (equal? word "d"))  (command 'move '(down))]
         [(or (equal? word "north")     (equal? word "n"))  (command 'move '(N))]
         [(or (equal? word "northeast") (equal? word "ne")) (command 'move '(NE))]
         [(or (equal? word "east")      (equal? word "e"))  (command 'move '(E))]
         [(or (equal? word "southeast") (equal? word "se")) (command 'move '(SE))]
         [(or (equal? word "south")     (equal? word "s"))  (command 'move '(S))]
         [(or (equal? word "southwest") (equal? word "sw")) (command 'move '(SW))]
         [(or (equal? word "west")      (equal? word "w"))  (command 'move '(W))]
         [(or (equal? word "northwest") (equal? word "nw")) (command 'move '(NW))]

         [(or (equal? word "diagnose")
              (equal? word "diagnostic"))
          (command 'diagnose '())]
         [(or (equal? word "l")
              (equal? word "look"))
          (command 'look '())]
         [(equal? word "score")
          (command 'score '())]
         [(equal? word "rank")
          (command 'rank '())]
         [(or (equal? word "quit")
              (equal? word "exit"))
          (command 'quit '())]
         [else unknown-sentence]))]

    [(= sentence-length 0)
     (command 'error '(input-empty))]

    [else
     unknown-sentence])))
