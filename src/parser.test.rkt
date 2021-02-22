#lang racket

; score
; restart
; quit/exit

; look
; look around
; inventory
; shout/scream -> Aaaarrrrgggghhhh!

; (direction)
; go (direction)

; examine (item)
; get/take/pick (item)
; get/take/pick all
; drop (item)

; attack/kill (creature) with (item)

(require rackunit
         "parser.rkt"
         "state.rkt")
(provide parser-tests)

(define parser-tests
  (test-suite "parser"

    (test-suite "parser/clean-input"
      (test-case "accepts empty input"
        (check-equal?
          (parser/clean-input "")
          ""))
      (test-case "leaves correct input alone"
        (check-equal?
          (parser/clean-input "abc")
          "abc")
        (check-equal?
          (parser/clean-input "abc def")
          "abc def"))
      (test-case "trims leading whitespace"
        (check-equal?
          (parser/clean-input "   abc")
          "abc"))
      (test-case "trims trailing whitespace"
        (check-equal?
          (parser/clean-input "abc \n")
          "abc"))
      (test-case "reduces multiple whitespace characters into one"
        (check-equal?
          (parser/clean-input "abc \t\n  def  ghi jkl")
          "abc def ghi jkl"))
      (test-case "lowercases a-z"
        (check-equal?
          (parser/clean-input "abc DEF ghi")
          "abc def ghi"))
      (test-case "replaces non-A-Z characters"
        (check-equal?
          (parser/clean-input "abc 123 ghi !@# mno")
          "abc ghi mno")))

    (test-suite "parser/words->command"
      (test-case "accepts empty input"
        (check-equal?
          (parser/words->command '())
          (command 'error '(input-empty))))
      (test-case "recognises `quit` command when given: quit"
        (check-equal?
          (parser/words->command '("quit"))
          (command 'quit '())))
      (test-case "recognises `quit` command when given: exit"
        (check-equal?
          (parser/words->command '("exit"))
          (command 'quit '()))))))
