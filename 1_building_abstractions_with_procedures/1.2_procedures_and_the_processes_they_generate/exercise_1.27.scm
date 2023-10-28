(load "../../sicplib.scm")

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
