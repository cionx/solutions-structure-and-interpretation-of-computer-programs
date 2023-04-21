# Exercise 2.07

> Alyssa’s program is incomplete because she has not specified the implementation of the interval abstraction.
> Here is a definition of the interval constructor:
> ```scheme
>   (define (make-interval a b) (cons a b))
> ```
> Define selectors `upper-bound` and `lower-bound` to complete the implementation.



The two selectors are as follows:
```scheme
(define (lower-bound x)
  (car x))

(define (upper-bound x)
  (cdr x))
```
