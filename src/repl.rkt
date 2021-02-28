#lang racket

(require "state.rkt"
         "parser.rkt")

(provide repl/loop
         repl/handler)

(define (repl/loop)
  ; request, capture and handle user input
  (display "\n>")
  (repl/handler (read-line))

  ; recur
  (repl/loop))

(define (repl/handler input)
  (let* ([cmd (parser/parse input)]
         [xs (state/update cmd)])
    (for ([s xs])
      (display (string-append s "\n")))))
