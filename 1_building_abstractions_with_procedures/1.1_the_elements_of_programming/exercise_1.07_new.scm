(load "../../sicplib.scm")

(define (improve guess x)
  (average guess (/ x guess)))

(define (small-percentage? x y)
  (< (abs x)
     (* 0.0001 (abs y))))

(define (good-enough? oldguess newguess)
  (small-percentage? (- oldguess newguess) oldguess))

(define (sqrt-iter-start guess x)
  (sqrt-iter-cmp guess
                 (improve guess x)
                 x))

(define (sqrt-iter-cmp oldguess newguess x)
  (if (good-enough? oldguess newguess)
      newguess
      (sqrt-iter-start newguess x)))

(define (sqrt x)
  (cond ((= x 0) 0)
        ((= x +inf.0) +inf.0)
        (else (sqrt-iter-start 1.0 x))))
