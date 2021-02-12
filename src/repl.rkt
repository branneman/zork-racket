#lang racket

(require "./strings.rkt")

(provide repl/loop
         repl/handler
         repl/exit-handler)

(define (repl/loop)
  (display "\n>")
  (define input (read-line))
  (when (or (equal? input "quit") (equal? input "exit"))
    (repl/exit-handler))
  (display (repl/handler input))
  (repl/loop))

(define (repl/handler x)
  (string-append (string-replace (get-string 'input-unknown-word) "%%" x) "\n"))

(define (repl/exit-handler)
  (define score (get-string 'score))
  (define rank (get-string 'rank))
  (display (string-append score "\n" rank "\n"))
  (exit))
