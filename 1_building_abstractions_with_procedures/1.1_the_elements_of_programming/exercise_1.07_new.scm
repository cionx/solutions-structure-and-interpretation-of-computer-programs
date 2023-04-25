(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (small-percentage? x y)
  (< (abs x)
     (* 0.0001 (abs y))))

(define (good-enough? oldguess newguess)
  (small-percentage? (- oldguess newguess) oldguess))

(define (sqrt-iter-1 guess x)
  (sqrt-iter-2 guess
               (improve guess x)
               x))

(define (sqrt-iter-2 oldguess newguess x)
  (if (good-enough? oldguess newguess)
      newguess
      (sqrt-iter-1 newguess x)))

(define (sqrt x)
  (cond ((= x 0.) 0.)
        ((= x +inf.0) +inf.0)
        (else (sqrt-iter-1 1.0 x))))
