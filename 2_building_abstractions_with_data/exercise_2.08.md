# Exercise 2.8

> Using reasoning analogous to Alyssa’s, describe how the difference of two intervals may be computed.
> Define a corresponding subtraction procedure, called `sub-interval`.



The difference of two intervals can be computed as follows:
```scheme
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))
```

Alternatively, we can first define a negated interval, and then use addition:

```scheme
(define (negative x)
  (make-interval (- (upper-bound x))
                 (- (lower-bound x))))

(define (sub-interval x y)
  (add-interval x (negative y)))
```
