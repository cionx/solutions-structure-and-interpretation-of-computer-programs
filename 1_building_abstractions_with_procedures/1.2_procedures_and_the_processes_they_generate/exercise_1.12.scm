(define (binom n k)
  (cond ((= k 0) 1)
        ((= k n) 1)
        (else (+ (binom (- n 1) (- k 1))
                 (binom (- n 1) k)))))
