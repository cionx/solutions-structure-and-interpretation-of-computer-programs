# Exercise 2.1

> Define a better version of `make-rat` that handles both positive and negative arguments.
> `make-rat` should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if the rational number is negative, only the numerator is negative.



We use the following code:
```scheme
(define (make-rat n d)
  (define (simplify-and-make n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (if (< d 0)
      (simplify-and-make (- n) (- d))
      (simplify-and-make n d)))
```
