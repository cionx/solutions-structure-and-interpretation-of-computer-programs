(load "exercise_1.22.scm")

(define (smallest-divisor n)
  (if (even? n)
      2
      (find-divisor n 3)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 2)))))
