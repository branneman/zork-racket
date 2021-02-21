#lang racket

(require "strings.rkt")
(require "leveldata.rkt")
(require "state.rkt")
(require "parser.rkt")

(provide repl/loop
         repl/handler)

(define (repl/loop)
  ; print location name + description if this is the first visit
  (when (not (state/has-visited (state/get-location)))
    (display (string-append "\n" (leveldata-label (state/get-location)) "\n"))
    (display (string-append (leveldata-description (state/get-location)) "\n"))
    (state/set-visited (state/get-location)))

  ; request & capture user input
  (display "\n>")
  (define input (read-line))

  (repl/handler input)
  (repl/loop))

(define (repl/handler input)
  (let* ([command (parser/parse input)]
         [reply (state/update command)])
    (for ([str reply])
      (display (string-append str "\n")))))
