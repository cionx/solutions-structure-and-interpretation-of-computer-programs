# Exercise 2.10

> Ben Bitdiddle, an expert systems programmer, looks over Alyssa’s shoulder and comments that it is not clear what it means to divide by an interval that spans zero.
> Modify Alyssa’s code to check for this condition and to signal an error if it occurs.

---

We use an auxiliary procedure that checks if an interval contains zero:
```scheme
(define (contains-zero? x)
  (and (<= (lower-bound x) 0)
       (<= 0 (upper-bound x))))
```
We now incorporate this new procedure into the definition of `div-interval`.
```scheme
(define (div-interval x y)
  (if (contains-zero? y)
      (error "Division by zero in div-interval.")
      (mul-interval x
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))
```
