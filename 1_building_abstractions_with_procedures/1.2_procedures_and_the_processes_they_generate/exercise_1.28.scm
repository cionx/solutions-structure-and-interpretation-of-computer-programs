(load "../../sicplib.scm") ;; for square

;; find all primes from `from` to `to` (inclusive)
(define (find-primes from to)
  (find-primes-iter from to))

(define (find-primes-iter test limit)
  (when (<= test limit)
    (when (fast-prime? test 100)
      (display test)
      (newline))
    (find-primes-iter (+ test 1) limit)))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((milner-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

;; checks if a^(n - 1) ≡ 1 modulo n
;; for some random a between 1 and (n - 1)
(define (milner-rabin-test n)
  (define (try-it a)
    (= 1 (expmod a (- n 1) n)))
  (try-it (+ 1 (random (- n 1)))))

;; computes base^exp modulo n,
;; returns 0 if we encountered a non-trivial root of unity along the way
(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp)
         (square-check (expmod base (/ exp 2) n)
                       n))
        (else
         (remainder (* base (expmod base (- exp 1) n))
                    n))))

;; square x modulo n,
;; returns 0 if x is a non-trivial root of 1 modulo n
(define (square-check x n)
  (define result
    (remainder (square x) n))
  (if (and (= 1 result)
           (not (= x 1))
           (not (= x (- n 1))))
      0
      result))
