(load "exercise_1.22.scm") ;; also loads sicplib

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next k)
  (if (= k 2) 3 (+ k 2)))
