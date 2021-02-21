#lang racket

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

(suite "state/get-rank" (λ ()
  (assert "0" "Beginner" (state/get-rank 0))
  (assert "24" "Beginner" (state/get-rank 24))
  (assert "25" "Amateur Adventurer" (state/get-rank 25))
  (assert "50" "Novice Adventurer" (state/get-rank 50))
  (assert "100" "Junior Adventurer" (state/get-rank 100))
  (assert "200" "Adventurer" (state/get-rank 200))
  (assert "300" "Master" (state/get-rank 300))
  (assert "330" "Wizard" (state/get-rank 330))
  (assert "350" "Master Adventurer" (state/get-rank 350))
))
