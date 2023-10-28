(load "../../sicplib.scm")

;;; For testing sequences of numbers.

(define (smallest-primes n count)
  (if (> count 0)
      (begin (timed-prime-test n)
             (smallest-primes (+ n 1) (- count 1)))
      (begin (newline)
             (display "*** end ***"))))
