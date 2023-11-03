# Exercise 1.39

> A continued fraction  representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert:
> $$
>   \tan x = \cfrac{x}{1 - \cfrac{x^2}{3 - \cfrac{x^2}{5 - {⋱}}}}\,,
> $$
> where $x$ is in radians.
> Define a procedure `(tan-cf x k)` that computes an approximation to the tangent function based on Lambert’s formula.
> `k` specifies the number of terms to compute, as in Exercise 1.37.

---

We can implement the desired procedure as follows:
```scheme
(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
        x
        (- (square x))))
  (define (d i)
    (- (* 2 i) 1))
  (cont-frac n d k))
```

We can check our procedure against the built-in `tan` procedure of `mit-scheme`:
```text
1 ]=> (tan 10)

;Value: .6483608274590866

1 ]=> (tan-cf 10 100)

;Value: .6483608274590866
```
