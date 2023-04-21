# Exercise 2.12

> Define a constructor `make-center-percent` that takes a center and a percentage tolerance and produces the desired interval.
> You must also define a selector `percent` that produces the percentage tolerance for a given interval.
> The `center` selector is the same as the one shown above.



We use the following code:
```scheme
(define (make-center-percent c percent)
  (let ((w (* (/ percent 100)
              (abs c))))
    (make-center-width c w)))

(define (center i)
  (define (average x y) (/ (+ x y) 2))
  (average (lower-bound i) (upper-bound i)))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percentage i)
  (let ((c (abs (center i))))
    (if (= c 0)
        (error "Division by zero in percentage.")
        (/ (width i) c))))
```
