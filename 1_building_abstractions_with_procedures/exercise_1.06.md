# Exercise 1.6

> Alyssa P. Hacker doesn’t see why `if` needs to be provided as a special form.
> “Why can’t I just define it as an ordinary procedure in terms of `cond`?” she asks.
> Alyssa’s friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:
> ```scheme
> (define (new-if predicate then-clause else-clause)
>   (cond (predicate then-clause)
>         (else else-clause)))
> ```
> Eva demonstrates the program for Alyssa:
> ```scheme
> (new-if (= 2 3) 0 5)
> 5
>
> (new-if (= 1 1) 0 5)
> 0
> ```
> Delighted, Alyssa uses `new-if` to rewrite the square-root program:
> ```scheme
> (define (sqrt-iter guess x)
>   (new-if (good-enough? guess x)
>           guess
>           (sqrt-iter (improve guess x) x)))
> ```
> What happens when Alyssa attempts to use this to compute square roots?
> Explain.



We can use `new-if` to define the following procedures `new-sqrt-iter` and `new-sqrt`:
```scheme
(define (new-sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (new-sqrt-iter (improve guess x) x)))
```
Suppose that we are given two numbers `g` and `x`, and that we want to evaluate the expression `(new-sqrt-iter g x)`.
This means that we need to evaluate the following expression:
```scheme
(new-if (good-enough? g x)
        g
        (new-sqrt-iter (improve guess x) x)))
```
This expression is a combination.
Evaluating it begins by evaluating all four subexpressions

- `new-if`,
- `(good-enough? g x)`,
- `g`,
- `(new-sqrt-iter (improve guess x) x)`.

The first three subexpressions pose no problem.
But the fourth expression is a combination whose leftmost entry is the procedure `new-sqrt-iter` that we started with.

So whenever we want to apply the procedure `new-sqrt-iter` (to two arguments), we first need to apply this procedure (to two other arguments).
We are thus trapped in an endless loop of trying to apply `new-sqrt-iter`.
Therefore, the original evaluation of `(new-sqrt g x)` never terminates.
