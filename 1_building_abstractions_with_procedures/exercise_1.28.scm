(define (find-primes from to)
  (find-primes-iter from to))

(define (find-primes-iter test limit)
  (when (<= test limit)
        (when (fast-prime? test 100)
              (display test)
              (newline))
        (find-primes-iter (+ 1 test) limit)))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((milner-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (milner-rabin-test n)
  (define (try-it a)
    (= 1 (expmod a (- n 1) n)))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp)
         (square-check (expmod base (/ exp 2) n)
                       n))
        (else
         (remainder (* base (expmod base (- exp 1) n))
                    n))))

(define (square-check previous n)
  (define result
    (remainder (square previous) n))
  (if (and (= 1 result)
           (not (= previous 1))
           (not (= previous (- n 1))))
      0
      result))

(define (square x) (* x x))
