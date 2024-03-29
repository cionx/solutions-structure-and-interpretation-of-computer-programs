(load "exercise_1.37.scm") ; for `cont-frac`

(define (euler-fraction k)
  (define (n i) 1.0)
  (define (d i)
    (if (= 2 (remainder i 3))
        (* 2 (+ 1 (quotient i 3)))
        1.0))
  (cont-frac n d k))

(define (e-approx k)
  (+ 2.0 (euler-fraction k)))
