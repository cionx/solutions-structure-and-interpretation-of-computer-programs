; copied from the book

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x) (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; written myself

(define (find-carmichael limit)
  (find-carmichael-iter 1 limit))

(define (find-carmichael-iter n limit)
  (when (carmichael? n)
        (display n)
        (newline))
  (when (<= n limit)
        (find-carmichael-iter (+ n 1) limit)))

(define (carmichael? n)
  (and (maybe-prime? n)
       (not (prime? n))))

(define (maybe-prime? n)
  (maybe-prime-iter 1 n))

(define (maybe-prime-iter a n)
  (or (>= a n)
      (and (= a (expmod a n n))
           (maybe-prime-iter (+ a 1) n))))
