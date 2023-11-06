# Exercise 2.1

> Define a better version of `make-rat` that handles both positive and negative arguments.
> `make-rat` should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if the rational number is negative, only the numerator is negative.

---

If the denominator is negative, then we swap the sign of both the numerator and denominator.
The sign of the numerator remains otherwise unchanged.

To produce a rational number we use the same code as in the book, with one minor modification:
we compute the greatest common divisor of $|n|$ and $d$, so that the used `gcd` procedure only has to support non-negative integers.

```scheme
(define (make-rat n d)
  (if (negative? d)
      (make-rat (- n) (- d))
      (let ((g (gcd (abs n) d)))
        (cons (/ n g) (/ d g)))))
```
