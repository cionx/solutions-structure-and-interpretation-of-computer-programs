(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (dampen f)
  (lambda (x)
    (/ (+ x (f x)) 2)))

(define (fixed-point-dampen f first-guess)
  (fixed-point (dampen f) first-guess))
