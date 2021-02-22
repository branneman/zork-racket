#lang racket

(require rackunit/text-ui)

(require "src/parser.test.rkt")
(void (run-tests parser-tests))

(require "src/state.test.rkt")
(void (run-tests state-tests))