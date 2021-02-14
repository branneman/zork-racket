#lang racket

(require graph)
(require "src/repl.rkt")
(require "src/strings.rkt")
(require "src/leveldata.rkt")

(display (get-string 'intro))

(repl/loop)
