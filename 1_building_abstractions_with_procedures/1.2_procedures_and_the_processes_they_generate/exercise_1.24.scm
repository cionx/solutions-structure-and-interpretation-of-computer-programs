;;; Often used background code.

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))



;;; Code given by the exercise, with the modification
;;; to start-prime-test that the exercise asks for.

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 1000000)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))



; For testing sequences of numbers.

(define (smallest-primes n count)
  (if (> count 0)
      (begin (timed-prime-test n)
             (smallest-primes (+ n 1) (- count 1)))
      (begin (newline)
             (display "*** end ***"))))
