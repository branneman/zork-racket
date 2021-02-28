#lang racket

(require rackunit
         "level.rkt")
(provide level-tests)

(define level-tests
  (test-suite
   "level"

   (test-suite
    "level/get-edges"
    (test-case "returns edges, not vertexes"
      (graph-part 'a "" "" '((N b)
                             (S c)))
      (graph-part 'b "" "" '((S a)
                             (N c)))
      (graph-part 'c "" "" '((N a)
                             (S b)))
      (check-equal?
       (level/get-edges 'b)
       '((N c) (S a)))))))
