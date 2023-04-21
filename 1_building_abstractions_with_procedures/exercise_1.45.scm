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
    (fixed-point
      ((repeated average-damp k) f)
      1.0)))



(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define tolerance 0.00001)

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (average x y)
  (/ (+ x y) 2))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 0)
      (lambda (x) x)
      (compose f (repeated f (- n 1)))))
