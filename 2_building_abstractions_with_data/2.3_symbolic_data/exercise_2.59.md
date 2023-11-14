# Exercise 2.59

> Implement the `union-set` operation for the unordered-list representation of sets.

---

We can implement `union-set` by successively adjoining the elements of `set1` to `set2`.
```scheme
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (adjoin-set (car set1)
                          (union-set (cdr set1) set2)))))
```
