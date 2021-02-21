#lang racket

(require graph)
(require "src/repl.rkt")
(require "src/strings.rkt")

(display (get-string 'intro))

(repl/loop)
