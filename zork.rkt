#lang racket

(require graph)
(require "src/repl.rkt")
(require "src/strings.rkt")
(require "src/leveldata.rkt")

(display (get-string 'intro))

(define (get-initial-state)
  (string-append
    "\n"
    (leveldata-label 'west-of-house) "\n"
    (leveldata-description 'west-of-house) "\n"))

; Print initial state, start REPL
(display (get-initial-state))
(repl/loop)
