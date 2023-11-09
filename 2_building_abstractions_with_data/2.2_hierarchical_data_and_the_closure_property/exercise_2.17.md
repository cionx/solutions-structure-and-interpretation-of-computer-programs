# Exercise 2.17

> Define a procedure `last-pair` that returns the list that contains only the last element of a given (nonempty) list:
> ```scheme
> (last-pair (list 23 72 149 34))
> (34)
> ```

---

We split up the input list into two parts:
its _head_ (its first element) and its _tail_ (the rest of the list).
If the tail is empty, then we return the list that consists only of the head.
Otherwise, we recursively descend into the tail.

We also check if the original input list in nonempty, and throw an error otherwise.

We can write the described procedure `last-pair` as follows:
```scheme
(define (last-pair items)
  (define (iter seq)
    (let ((head (car seq))
          (tail (cdr seq)))
      (if (null? tail)
          (list head)
          (last-pair tail))))
  (if (null? items)
      (error "Empty list in last-pair")
      (iter items)))
```
