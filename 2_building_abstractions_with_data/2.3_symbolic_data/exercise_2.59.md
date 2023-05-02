# Exercise 2.59

> Implement the `union-set` operation for the unordered-list representation of sets.



We can implement `union-set` as follows:
```scheme
(define (union-set set1 set2)
  (if (null? set1)
      set2
      (let ((element (car set1))
            (smaller-union (union-set (cdr set1) set2)))
        (if (element-of-set? element set2)
            smaller-union
            (cons element smaller-union)))))
```
