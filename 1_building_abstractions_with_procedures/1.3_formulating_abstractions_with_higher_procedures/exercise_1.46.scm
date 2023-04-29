(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  iter)



(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve y)
    (average y (/ x y)))
  ((iterative-improve good-enough? improve) 1.0))



(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 0.00001))
  (define (good-enough? guess)
    (close-enough? guess (f guess)))
  ((iterative-improve good-enough? f) first-guess))



(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))
