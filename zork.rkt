#lang racket

(display "ZORK-RACKET I\n")
(display "Unlicense\n")
(display "ZORK is a registered trademark of Infocom, Inc.\n")

; Read-Eval-Print-Loop
(define (loop)
  (display "\n>")
  (define input (read-line))
  (when (or (equal? input "quit") (equal? input "exit"))
    (exit-handler))
  (display (handler input))
  (loop))

(define (handler x)
  (string-append "I don't know the word \"" x "\"\n"))

(define (exit-handler)
  (define score "Your score is 0 (total of 350 points), in 0 moves.")
  (define rank "This gives you the rank of Beginner.")
  (display (string-append score "\n" rank "\n"))
  (exit))

(define (get-initial-state)
  (define title "West of House")
  (define sentence "You are standing in an open field west of a white house, with a boarded front door.\nThere is a small mailbox here.")
  (string-append "\n" title "\n" sentence "\n"))

; Print initial state, start REPL
(display (get-initial-state))
(loop)
