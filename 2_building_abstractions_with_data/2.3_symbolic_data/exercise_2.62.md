# Exercise 2.62

> Give a $Θ(n)$ implementation of `union-set` for sets represented as ordered lists.

---

We can implement `union-set` similarly to `intersection-set`:
```scheme
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
               (x2 (car set2))
               (rest1 (cdr set1))
               (rest2 (cdr set2)))
           (cond ((= x1 x2)
                  (cons x1 (union-set rest1 rest2)))
                 ((< x1 x2)
                  (cons x1 (union-set rest1 set2)))
                 ((> x1 x2)
                  (cons x2 (union-set set1 rest2))))))))

```

Note that to form the union of two sets of respective sizes $m$ and $n$ we are first taking the union of two sets of total size either $m + n - 1$ or $m + n - 2$, and then add to this a constant amount of steps.
We have therefore a running time of $O(m + n)$.
