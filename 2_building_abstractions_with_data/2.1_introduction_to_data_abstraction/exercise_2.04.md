# Exercise 2.4

> Here is an alternative procedural representation of pairs.
> For this representation, verify that `(car (cons x y))` yields `x` for any objects `x` and `y`.
> ```scheme
> (define (cons x y)
>   (lambda (m) (m x y)))
>
> (define (car z)
>   (z (lambda (p q) p)))
> ```
> What is the corresponding definition of `cdr`?
> (Hint:
> To verify that this works, make use of the substitution model of Section 1.1.5.)



The corresponding definition of `cdr` is as follows:
```scheme
(define (cdr z)
  (z (lambda (p q) q)))
```
