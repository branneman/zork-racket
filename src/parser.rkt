#lang racket

(require "state.rkt")

(provide parser/parse
         parser/clean-input
         parser/replace-aliases
         parser/words->command)

; parser/parse :: string -> command<id,variables>
(define (parser/parse input)
  (let* ([cleaned (parser/clean-input input)]
         [split (string-split cleaned " ")]
         [words (parser/replace-aliases split)])
    (parser/words->command words)))

; parser/clean-input :: string -> string
(define parser/clean-input
  (compose1 string-downcase
            string-trim
            (λ (s) (string-replace s #px"\\s+" " "))
            (λ (s) (string-replace s #px"[^a-zA-Z\\s]" ""))))

; parser/replace-aliases :: (string ...) -> (string ...)
(define (parser/replace-aliases words)
  (map (λ (x)
         (case x
           [("climb" "u")  "up"]
           [("d")  "down"]
           [("n")  "north"]
           [("ne") "northeast"]
           [("e")  "east"]
           [("se") "southeast"]
           [("s")  "south"]
           [("sw") "southwest"]
           [("w")  "west"]
           [("nw") "northwest"]

           [("l") "look"]

           [("go" "head" "walk") "move"]

           [("diagnostic") "diagnose"]

           [("scream") "shout"]

           [("exit" "q") "quit"]
           [else x]))
       words))

; parser/words->command :: (string ...) -> command<id,variables>
(define (parser/words->command words)
  (let* ([sentence-length (length words)]
         [unknown-sentence (command 'error '(input-unknown-sentence))])
    (cond

      [(> sentence-length 2)
       unknown-sentence]

      [(= sentence-length 2)
       (cond
         [(equal? words '("look" "around"))
          (command 'look '())]
         [(equal? (first words) "move")
          (let ([dir (case (second words)
                       [("up")        'up]
                       [("down")      'down]
                       [("north")     'N]
                       [("northeast") 'NE]
                       [("east")      'E]
                       [("southeast") 'SE]
                       [("south")     'S]
                       [("southwest") 'SW]
                       [("west")      'W]
                       [("northwest") 'NW])])
            (if (not (void? dir))
                (command 'move (list dir))
                unknown-sentence))]
         [else unknown-sentence])]

      [(= sentence-length 1)
       (let ([word (first words)])
         (case word
           [("up")        (command 'move '(up))]
           [("down")      (command 'move '(down))]
           [("north")     (command 'move '(N))]
           [("northeast") (command 'move '(NE))]
           [("east")      (command 'move '(E))]
           [("southeast") (command 'move '(SE))]
           [("south")     (command 'move '(S))]
           [("southwest") (command 'move '(SW))]
           [("west")      (command 'move '(W))]
           [("northwest") (command 'move '(NW))]

           [("diagnose")  (command 'diagnose '())]
           [("shout")     (command 'shout '())]
           [("look")      (command 'look '())]
           [("score")     (command 'score '())]
           [("rank")      (command 'rank '())]
           [("restart")   (command 'restart '())]
           [("quit")      (command 'quit '())]
           [else unknown-sentence]))]

      [(= sentence-length 0)
       (command 'error '(input-empty))]

      [else
       unknown-sentence])))
