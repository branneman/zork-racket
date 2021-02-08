#lang racket

(display "Welcome to zork-racket.\n")

(define (handler x)
  (string-append "I do not understand " x "\n"))

; Read-Eval-Print-Loop
(let loop ()
  (display "\n> ")
  (define input (read-line))
  (when (or (equal? input "quit") (equal? input "exit"))
    (exit))
  (display (handler input))
  (loop))
