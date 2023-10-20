# Exercise 1.8

> Newton’s method for cube roots is based on the fact that if $y$ is an approximation to the cube root of $x$, then a better approximation is given by the value
> $$
>   \frac{x / y^2 + 2y}{3} \,.
> $$
> Use this formula to implement a cube-root procedure analogous to the square-root procedure.
> (In Section 1.3.4 we will see how to implement Newton’s method in general as an abstraction of these square-root and cube-root procedures.)

---

We follow the same approach as in the previous exercise:
```scheme
(define (improve guess x)
  (/ (+ (/ x
           (* guess guess))
        (* 2 guess))
     3))

(define (good-enough? oldguess newguess)
  (small-percentage? (- oldguess newguess) newguess))

(define (small-percentage? x y)
  (< (abs x)
     (* 0.001 (abs y))))

(define (cbrt-iter-start guess x)
  (cbrt-iter-cmp guess (improve guess x) x))

(define (cbrt-iter-cmp oldguess newguess x)
  (if (good-enough? oldguess newguess)
      newguess
      (cbrt-iter-start newguess x)))

(define (cbrt x)
  (cond ((= x 0) 0)
        ((= x +inf.0) +inf.0)
        (else (cbrt-iter-start 1. x))))
```
