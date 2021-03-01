(module state racket
  (require rackunit
           "state.rkt")

  (module+ test
    ; state/get-rank
    (test-case "0-24: Beginner"
      (check-equal? (state/get-rank 0) "Beginner")
      (check-equal? (state/get-rank 24) "Beginner"))
    (test-case "25-49: Amateur Adventurer"
      (check-equal? (state/get-rank 25) "Amateur Adventurer")
      (check-equal? (state/get-rank 49) "Amateur Adventurer"))
    (test-case "50-99: Novice Adventurer"
      (check-equal? (state/get-rank 50) "Novice Adventurer")
      (check-equal? (state/get-rank 99) "Novice Adventurer"))
    (test-case "100-199: Junior Adventurer"
      (check-equal? (state/get-rank 100) "Junior Adventurer")
      (check-equal? (state/get-rank 199) "Junior Adventurer"))
    (test-case "200-299: Adventurer"
      (check-equal? (state/get-rank 200) "Adventurer")
      (check-equal? (state/get-rank 299) "Adventurer"))
    (test-case "300-329: Master"
      (check-equal? (state/get-rank 300) "Master")
      (check-equal? (state/get-rank 329) "Master"))
    (test-case "330-349: Wizard"
      (check-equal? (state/get-rank 330) "Wizard")
      (check-equal? (state/get-rank 349) "Wizard"))
    (test-case "350: Master Adventurer"
      (check-equal? (state/get-rank 350) "Master Adventurer"))
    (test-case "350-∞: Cheater"
      (check-equal? (state/get-rank 351) "Cheater")
      (check-equal? (state/get-rank 1000) "Cheater"))

    ; state/update
    (test-case "throws error when given unknown command"
      (check-exn exn:fail?
                 (λ () (state/update (command 'foobar '())))))))
