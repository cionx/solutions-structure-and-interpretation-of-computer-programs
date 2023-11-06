# Exercise 2.8

> Using reasoning analogous to Alyssa’s, describe how the difference of two intervals may be computed.
> Define a corresponding subtraction procedure, called `sub-interval`.

---

Given two intervals $I = [l_1, u_1]$ and $J = [l_2, u_2]$, the smallest element of $I - J$ is $l_1 - u_2$, and the largest element of $I - J$ is $u_1 - l_2$.
The difference of two intervals can therefore be computed as follows:
```scheme
(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))
```

Alternatively we can first define a negated interval and then use addition:

```scheme
(define (negate-interval x)
  (make-interval (- (upper-bound x))
                 (- (lower-bound x))))

(define (sub-interval x y)
  (add-interval x (negate-interval y)))
```
