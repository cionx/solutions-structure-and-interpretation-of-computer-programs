(define (improve guess x)
  (/ (+ (/ x
           (* guess guess))
        (* 2 guess))
     3))

(define (good-enough? oldguess newguess)
  (small-percentage? (- oldguess newguess) newguess))

(define (small-percentage? x y)
  (< (abs x)
     (* 0.001 (abs y))))

(define (cbrt-iter-start guess x)
  (cbrt-iter-cmp guess (improve guess x) x))

(define (cbrt-iter-cmp oldguess newguess x)
  (if (good-enough? oldguess newguess)
      newguess
      (cbrt-iter-start newguess x)))

(define (cbrt x)
  (cond ((= x 0) 0)
        ((= x +inf.0) +inf.0)
        (else (cbrt-iter-start 1. x))))
