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

(require "parser.rkt")
(require "state.rkt")

(define (suite name body)
  (display (string-append "\n" name "\n"))
  (body)
  (display "    ALL PASSED\n"))
(define (assert desc expect actual)
  (if (equal? expect actual)
    (begin
      (display (string-append "    PASS: " desc "\n")))
    (begin
      (display (string-append "\n    FAIL: " desc "\n"))
      (display (string-append "  EXPECT: "))
      (print expect)
      (display (string-append "\n  ACTUAL: "))
      (print actual)
      (display "\n")
      (exit 1))))

(suite "parser/clean-input" (λ ()
  (assert "accepts empty input"
    ""
    (parser/clean-input ""))
  (assert "leaves correct input alone"
    "abc"
    (parser/clean-input "abc"))
  (assert "trims leading whitespace"
    "abc"
    (parser/clean-input "   abc"))
  (assert "trims trailing whitespace"
    "abc"
    (parser/clean-input "abc \n"))
  (assert "reduces multiple whitespace characters into one"
    "abc def ghi jkl"
    (parser/clean-input "abc \t\n  def  ghi jkl"))
  (assert "lowercases a-z"
    "abc def ghi"
    (parser/clean-input "abc DEF ghi"))
  (assert "replaces non-A-Z characters"
    "abc ghi mno"
    (parser/clean-input "abc 123 ghi !@# mno"))))

(suite "parser/words->command" (λ ()
  (assert "accepts empty input"
    (command 'error '(input-empty))
    (parser/words->command '()))
  (assert "recognises `quit` command when given: quit"
    (command 'quit '())
    (parser/words->command '("quit")))
  (assert "recognises `quit` command when given: exit"
    (command 'quit '())
    (parser/words->command '("exit")))
))
