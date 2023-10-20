# Exercise 1.3

> Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

---

We can use the following code:
```scheme
(define (square x)
  (* x x))

(define (sum-of-squares x y)
  (+ (square x)
     (square y)))

(define (sum-of-squares-max2 x y z)
  (if (> x y)
      (if (> y z)
          (sum-of-squares x y)
          (sum-of-squares x z))
      (if (> x z)
          (sum-of-squares x y)
          (sum-of-squares y z))))
```
