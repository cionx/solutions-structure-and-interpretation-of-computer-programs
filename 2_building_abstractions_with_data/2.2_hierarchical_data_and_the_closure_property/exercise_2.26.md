# Exercise 2.26

> Suppose we define `x` and `y` to be two lists:
> ```scheme
> (define x (list 1 2 3))
>
> (define y (list 4 5 6))
> ```
> What result is printed by the interpreter in response to evaluating each of the
> following expressions:
> ```scheme
> (append x y)
>
> (cons x y)
>
> (list x y)
> ```

---

The expression `(append x y)` will result in `(1 2 3 4 5 6)`, the expression `cons x y` will result in `((1 2 3) 4 5 6)`, and the expression `(list x y)` will result in `((1 2 3) (4 5 6))`.
We can verify these claims with `mit-scheme`:
```text
1 ]=> (append x y)

;Value: (1 2 3 4 5 6)

1 ]=> (cons x y)

;Value: ((1 2 3) 4 5 6)

1 ]=> (list x y)

;Value: ((1 2 3) (4 5 6))
```
