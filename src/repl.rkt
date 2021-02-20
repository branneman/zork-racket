#lang racket

(require "strings.rkt")
(require "leveldata.rkt")
(require "parser.rkt")
;(require "state-machine.rkt")

(provide repl/loop
         repl/handler
         repl/execute
         repl/exit)

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
  (let* ([command (parser/parse input)]
         [reply (repl/execute command)])
    (for ([str reply])
      (display (string-append str "\n")))))

(define (repl/execute command)
  (case (command-id command)
    ['quit (repl/exit)]
    ['error (list (get-string (first (command-variables command))))]
    [else "yolo"]
  ))

(define (repl/exit)
  (let ([score (get-string 'score)]
        [rank (get-string 'rank)])
    (display (string-append score "\n" rank "\n"))
    (exit)))
