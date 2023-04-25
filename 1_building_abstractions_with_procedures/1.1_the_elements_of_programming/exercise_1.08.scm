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

(define (cbrt-iter-1 guess x)
  (cbrt-iter-2 guess (improve guess x) x))

(define (cbrt-iter-2 oldguess newguess x)
  (if (good-enough? oldguess newguess)
      newguess
      (cbrt-iter-1 newguess x)))

(define (cbrt x)
  (cond ((= x 0.) 0.)
        ((= x +inf.0) +inf.0)
        (else (cbrt-iter-1 1. x))))
