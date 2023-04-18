; From the previous text.

(define (smallest-divisor n)
  (find-divisor n))

(define (find-divisor n)
  (if (divides? 2 n)
      2
      (find-divisor-iter n 3)))

(define (find-divisor-iter n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor-iter n (+ 2 test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; From the exercise.

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; for testing sequences of numbers

(define (smallest-primes n count)
  (if (> count 0)
      (begin
        (timed-prime-test n)
        (smallest-primes (+ n 1) (- count 1)))
      (begin
        (newline)
        (display "*** end ***"))))
