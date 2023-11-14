# Exercise 2.60

> We specified that a set would be represented as a list with no duplicates.
> Now suppose we allow duplicates.
> For instance, the set $\{ 1, 2, 3 \}$ could be represented as the list `(2 3 2 1 3 2 2)`.
> Design procedures `element-of-set?`, `adjoin-set`, `union-set`, and `intersection-set` that operate on this representation.
> How does the efficiency of each compare with the corresponding procedure for the non-duplicate representation?
> Are there applications for which you would use this representation in preference to the non-duplicate one?

---

We can implement these functions with the following procedures:
```scheme
(define (element-of-set? x set)
  (and (not (null? set))
       (or (equal? x (car set))
           (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (intersection-set set1 set2)
  (filter (lambda (x) (element-of-set? x set1)) set2))

(define (union-set set1 set2)
  (append set1 set2))
```

The implementation for `element-of-set? x set` didn’t change.
But the procedure will now take longer, since we might need to compare the element `x` with the same value multiple times.
We cannot express the running time of `elements-of-set?` in terms of the number of elements of the represented set anymore, since there is no limit to the number of duplicate entries.

The implementation of `adjoin-set` is now $Θ(1)$ instead of the previous $O(n)$.

The implementation for `intersection-set` didn’t change, but it will become slower because `element-of-set?` became slower.
As before, we cannot estimate the running time anymore, as it depends on the degree of duplication.

The procedure `union-set` will now be faster, and now takes $Θ(n)$.

This new representation for sets may be useful in situations in which we have far more insertions or unions than lookups or intersections, or in which we have only a relatively low chance for duplicate entries.
