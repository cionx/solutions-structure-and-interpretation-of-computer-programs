# Exercise 2.61

> Give an implementation of `adjoin-set` using the ordered representation.
> By analogy with `element-of-set?` show how to take advantage of the ordering to produce a procedure that requires on the average about half as many steps as with the unordered representation.



We can implement `adjoin-set` as follows:
```scheme
(define (adjoin-set x set)
  (if (null? set)
      (list x)
      (let ((y (car set)))
        (cond ((< x y) (cons x set))
              ((= x y) set)
              (else (cons y (adjoin-set x (cdr set))))))))
```
In the worst case, we need to traverse through the entire `set` to figure out that `x` was not contained in it.
In the best case, `x` is strictly smaller than the first – and thus smallest – element of `set`, and we can simply `cons` it.
On average, we should expect that for a `set` of size $n$, we need $n / 2$ many comparisons.
This gives a run time of $Θ(n)$, but an effective improvement by a factor of $2$.
