# Exercise 2.18

> Define a procedure `reverse` that takes a list as argument and returns a list of the same elements in reverse order:
> ```scheme
> (reverse (list 1 4 9 16 25))
> (25 16 9 4 1)
> ```

---

We can write the `reverse` procedure as follows:
```scheme
(define (reverse items)
  (define (iter seq rev-seq)
    (if (null? seq)
        rev-seq
        (let ((head (car seq))
              (tail (cdr seq)))
          (iter tail (cons head rev-seq)))))
  (iter items '())) ; '() is the empty list
```
