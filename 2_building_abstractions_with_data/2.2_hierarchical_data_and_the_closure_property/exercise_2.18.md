# Exercise 2.18

> Define a procedure `reverse` that takes a list as argument and returns a list of the same elements in reverse order:
> ```scheme
> (reverse (list 1 4 9 16 25))
> (25 16 9 4 1)
> ```



We can write the `reverse` procedure as follows:
```scheme
(define (reverse items)
  (define (iter input acc)
    (if (null? input)
        acc
        (let ((head (car input))
              (tail (cdr input)))
          (iter tail (cons head acc)))))
  (iter items (list )))
```
