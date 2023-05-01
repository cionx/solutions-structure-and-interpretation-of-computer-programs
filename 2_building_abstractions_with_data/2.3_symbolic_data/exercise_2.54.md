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



We can use the following code:
```scheme
(define (equal? input1 input2)
  (let ((is-pair-1 (pair? input1))
        (is-pair-2 (pair? input2)))
    (cond ((and (not is-pair-1)
                (not is-pair-2))
           (eq? input1 input2))
          ((and is-pair-1 is-pair-2)
           (and (equal? (car input1)
                        (car input2))
                (equal? (cdr input1)
                        (cdr input2))))
          (else false))))
```
