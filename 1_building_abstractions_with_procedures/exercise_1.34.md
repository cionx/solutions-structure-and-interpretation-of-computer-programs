# Exercise 1.34

> Suppose we define the procedure
> ```scheme
> (define (f g)
>   (g 2))
> ```
> Then we have
> ```scheme
> (f square)
> 4
>
> (f (lambda (z) (* z (+ z 1))))
> 6
> ```
> What happens if we (perversely) ask the interpreter to evaluate the combination `(f f)`?
> Explain.



The expression `(f f)` is evaluated to `(f 2)`, which is then further evaluated to `(2 2)`.
The expression `(2 2)` results in an error because `2` is not a procedure, and thus cannot be applied to another value.

We can verify our conjecture in `mit-scheme`:
```text
1 ]=> (define (f g) (g 2))

;Value: f

1 ]=> (f f)

;The object 2 is not applicable.
;To continue, call RESTART with an option number:
; (RESTART 2) => Specify a procedure to use in its place.
; (RESTART 1) => Return to read-eval-print level 1.

2 error>
```
