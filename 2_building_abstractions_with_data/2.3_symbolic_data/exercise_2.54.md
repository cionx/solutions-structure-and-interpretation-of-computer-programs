# Exercise 2.54

> Two lists are said to be `equal?` if they contain equal elements arranged in the same order.
> For example,
> ```scheme
>   (equal? '(this is a list) '(this is a list))
> ```
> is true, but
> ```scheme
>   (equal? '(this is a list) '(this (is a) list))
> ```
> is false.
> To be more precise, we can define `equal?` recursively in terms of the basic `eq?` equality of symbols by saying that `a` and `b` are `equal?` if they are both symbols and the symbols are `eq?`, or if they are both lists such that `(car a)` is `equal?` to `(car b)` and `(cdr a)` is `equal?` to `(cdr b)`.
> Using this idea, implement `equal?` as a procedure.

---

We can implement the procedure `equal?` as follows:
```scheme
(define (equal? a b)
  (or
    ; two symbols that are eq?
    (and (symbol? a) (symbol? b) (eq? a b))
    ; two empty lists
    (and (null? a) (null? b))
    ; two nonempty lists/pairs
    (and (pair? a)
         (pair? b)
         (not (null? a))
         (not (null? b))
         (equal? (car a) (car b))
         (equal? (cdr a) (cdr b)))))
```
