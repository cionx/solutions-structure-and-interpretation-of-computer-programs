# Exercise 2.38

> The `accumulate` procedure is also known as `fold-right`, because it combines the first element of the sequence with the result of combining all the elements to the right.
> There is also a `fold-left`, which is similar to `fold-right`, except that it combines elements working in the opposite direction:
> ```scheme
> (define (fold-left op initial sequence)
>   (define (iter result rest)
>     (if (null? rest)
>         result
>         (iter (op result (car rest))
>               (cdr rest))))
>   (iter initial sequence))
> ```
> What are the values of
> ```scheme
> (fold-right / 1 (list 1 2 3))
>
> (fold-left / 1 (list 1 2 3))
>
> (fold-right list nil (list 1 2 3))
>
> (fold-left list nil (list 1 2 3))
> ```
> Give a property that `op` should satisfy to guarantee that `fold-right` and `fold-left` will produce the same values for any sequence.

---

The first expression evaluates as follows:
```scheme
(fold-right / 1 (list 1 2 3))

(/ 1 (fold-right / 1 (list 2 3)))

(/ 1 (/ 2 (fold-right / 1 (list 3))))

(/ 1 (/ 2 (/ 3 (fold-right / 1 '()))))

(/ 1 (/ 2 (/ 3 1)))

(/ 1 (/ 2 3))

(/ 1 2/3)

3/2
```

The second expression evaluates as follows:
```scheme
(fold-left / 1 (list 1 2 3))

(iter 1 (list 1 2 3))

(iter (/ 1 1) (list 2 3))

(iter 1 (list 2 3))

(iter (/ 1 2) (list 3))

(iter 1/2 (list 3))

(/ 1/2 3)

1/6
```

The third expression evaluates as follows:
```scheme
(fold-right list '() (list 1 2 3))

(list 1 (fold-right list '() (list 2 3)))

(list 1 (list 2 (fold-right list '() (list 3))))

(list 1 (list 2 (list 3 (fold-right list '() '()))))

(list 1 (list 2 (list 3 '())))

(list 1 (list 2 ( 3 ()) ))

(list 1 (2 (3 ())) )

(1 (2 (3 ())))
```

The fourth expression evaluates as follows:
```scheme
(fold-left list '() (list 1 2 3))

(iter '() (list 1 2 3))

(iter (list '() 1) (list 2 3))

(iter (() 1) (list 2 3))

(iter (list (() 1) 2) (list 3))

(iter ((() 1) 2) (list 3))

(iter (list ((() 1) 2) 3) '())

(iter (((() 1) 2) 3) '())

(((() 1) 2) 3)
```

If the operation `op` as associative and the value `initial` is central with respect to `op` (i.e., `(op initial x)` and `(op x initial)` are equal for every `x`), then `(fold-left op initial sequence)` and `(fold-right op initial sequence)` are equal for every list `sequence`.
