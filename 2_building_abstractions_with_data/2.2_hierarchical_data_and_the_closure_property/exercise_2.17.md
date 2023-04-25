# Exercise 2.17

> Define a procedure `last-pair` that returns the list that contains only the last element of a given (nonempty) list:
> ```scheme
> (last-pair (list 23 72 149 34))
> (34)
> ```



We can write the described procedure `last-pair` as follows:
```scheme
(define (last-pair items)
  (define (iter input)
    (let ((head (car input))
          (tail (cdr input)))
      (if (null? tail)
          (list head)
          (last-pair tail))))
  (if (null? items)
      (error "Empty list in last-pair")
      (iter items)))
```
