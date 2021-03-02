#lang racket

(require "state.rkt"
         "parser.rkt")

(provide repl/loop
         repl/handler)

; read, eval, print, loop
(define (repl/loop)
  (display "\n>")
  (repl/handler (read-line))
  (repl/loop))

(define (repl/handler input)
  (let* ([cmd (parser/parse input)]
         [xs (state/update cmd)])
    (for ([s xs])
      (display s)
      (newline))))
