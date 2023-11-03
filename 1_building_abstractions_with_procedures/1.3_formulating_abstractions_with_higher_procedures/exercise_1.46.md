# Exercise 1.46

> Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as _iterative improvement_.
> Iterative improvement says that, to compute something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess.
> Write a procedure `iterative-improve` that takes two procedures as arguments:
> a method for telling whether a guess is good enough and a method for improving a guess.
> `iterative-improve` should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough.
> Rewrite the `sqrt` procedure of Section 1.1.7 and the `fixed-point` procedure of Section 1.3.3 in terms of `iterative-improve`.

---

We can implement the described procedure `iterative-improve` as follows:
```scheme
(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (if (good-enough? guess)
        guess
        (iter (improve guess))))
  iter)
```
We did not use `lambda` because we want the returned procedure to reference itself.

We can implement `sqrt` in terms of `iterative-improve` as follows:
```scheme
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve y)
    (average y (/ x y)))
  ((iterative-improve good-enough? improve) 1.0))
```

We can also implement `fixed-point` in terms of `iterative-improve` as follows:
```scheme
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 0.00001))
  (define (good-enough? guess)
    (close-enough? guess (f guess)))
  ((iterative-improve good-enough? f) first-guess))
```
However, it should be noted that this implementation needs to compute `(f guess)` twice for every iteration, which is worse than the original version of `fixed-point`.
