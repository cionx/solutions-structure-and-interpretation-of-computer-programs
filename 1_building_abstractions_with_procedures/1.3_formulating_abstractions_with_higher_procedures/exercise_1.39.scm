(load "../../sicplib.scm") ; for `square`
(load "exercise_1.37.scm") ; for `cont-frac`

(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
        x
        (- (square x))))
  (define (d i)
    (- (* 2 i) 1))
  (cont-frac n d k))
