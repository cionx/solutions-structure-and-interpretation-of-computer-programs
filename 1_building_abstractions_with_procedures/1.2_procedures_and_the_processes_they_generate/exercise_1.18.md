# Exercise 1.18

> Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.

---

We only have to expand our solution to Exercise 1.17 so that it can also handle negative integers:
```scheme
(define (*-fast a b)
  (if (< b 0)
      (*-fast (- a) (- b))
      (*-fast-iter 0 a b)))
```
