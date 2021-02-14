#lang racket

(require "strings.rkt")
(require "leveldata.rkt")

(provide repl/loop
         repl/handler
         repl/exit-handler)

(define (repl/loop)
  ; print location name + description if this is the first visit
  (when (not (has-visited (get-location)))
    (display (string-append "\n" (leveldata-label (get-location)) "\n"))
    (display (string-append (leveldata-description (get-location)) "\n"))
    (set-visited (get-location)))

  ; request & capture user input
  (display "\n>")
  (define input (read-line))

  (repl/handler input)
  (repl/loop))

(define (repl/handler input)
  ; parse input for exact match
  ; define arbitrary behaviour per match
  ; no match? print 'input-unknown-sentence
  (when (or (equal? input "quit") (equal? input "exit"))
    (repl/exit-handler))
  (display (string-append (string-replace (get-string 'input-unknown-word) "%%" input) "\n")))

(define (repl/exit-handler)
  (define score (get-string 'score))
  (define rank (get-string 'rank))
  (display (string-append score "\n" rank "\n"))
  (exit))
