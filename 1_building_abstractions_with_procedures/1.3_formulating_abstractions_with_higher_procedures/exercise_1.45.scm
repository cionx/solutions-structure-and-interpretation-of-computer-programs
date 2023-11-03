(load "exercise_1.43.scm") ; for `repeated`
(load "../../sicplib.scm") ; for `average` and `fixed-point`

;; from the book
(define (average-damp f)
  (lambda (x) (average x (f x))))



(define (root-damp x n k)
  (define (f y)
    (/ x (expt y (- n 1))))
  (fixed-point
    ((repeated average-damp k) f)
    1.0))



(define (root x n)
  (define (log2 x)
    (/ (log x) (log 2)))
  (define (log2int x)
    (inexact->exact (floor (log2 x))))
  (define (f y)
    (/ x (expt y (- n 1))))
  (let ((k (log2int n)))
    (root-damp x n k)))
