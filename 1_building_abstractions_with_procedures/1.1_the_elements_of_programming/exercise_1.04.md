# Exercise 1.4

> Observe that our model of evaluation allows for combinations whose operators are compound expressions.
> Use this observation to describe the behavior of the following procedure:
> ```scheme
> (define (a-plus-abs-b a b)
>   ((if (> b 0) + -) a b))
> ```


The expression `(> b 0)` evaluates to `#t` if `b` is positive, and evaluates to `0` otherwise.
Consequently, the slightly larger expression `(if (> b 0) + -)` evaluates to `+` if `b` is positive, and evaluates to `-` otherwise.
The even larger expression `((if (> b 0) + -) a b)` therefore evaluates to `a + b` if `b` is positive, and to `a - b` otherwise.
The procedure `a-plus-abs-b` hence implements the following mathematical function:
$$
  f(a, b)
  =
  \begin{cases}
    a + b & \text{if $b > 0$}, \\
    a - b & \text{otherwise}.
  \end{cases}
$$
Given that we have
$$
  |b|
  =
  \begin{cases}
    \phantom{-}b & \text{if $b > 0$}, \\
              -b & \text{otherwise},
  \end{cases}
$$
the function $f$ can (extensional) equivalently be expressed as
$$
  f(a, b) = a + |b| \,.
$$
So just as its name indicates, the procedure `a-plus-abs-b` adds together the first argument (named `a`) and the absolute value of the second argument (named `b`).
The procedure could equivalently be written as follows:
```scheme
(define (a-plus-abs-b) a b
  (if (> b 0) (+ a b) (- a b)))
```
(This is really just a spelled-out version of the original implementation.)
