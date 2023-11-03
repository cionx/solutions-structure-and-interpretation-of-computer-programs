# Exercise 1.41

> Define a procedure `double` that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice.
> For example, if `inc` is a procedure that adds $1$ to its argument, then `(double inc)` should be a procedure that adds $2$.
> What value is returned by
> ```scheme
> (((double (double double)) inc) 5)
> ```

---

We can implement `double` as follows:
```scheme
(define (double f)
  (lambda (x) (f (f x))))
```

In mathematical notation, we have $\operatorname{double}(f) = f ∘ f = f^2$.
Therefore,
$$
  \begin{aligned}
  \operatorname{double}(\operatorname{double})(f)
  &=
  \operatorname{double}^2(f) \\
  &=
  \operatorname{double}(\operatorname{double}(f)) \\
  &=
  \operatorname{double}(f^2) \\
  &=
  (f^2)^2 \\
  &=
  f^4 \,.
  \end{aligned}
$$
Consequently,
$$
  \begin{aligned}
  (\operatorname{double}(\operatorname{double}(\operatorname{double}))(f)
  &=
  \operatorname{double}(\operatorname{double})^2(f) \\
  &=
  \operatorname{double}(\operatorname{double})
  \Bigl(
    \operatorname{double}(\operatorname{double})(f)
  \Bigr) \\
  &=
  \operatorname{double}(\operatorname{double})(f^4) \\
  &=
  (f^4)^4 \\
  &=
  f^{16} \,.
  \end{aligned}
$$

We see that `((double (double double)) inc)` should be a procedure that increases its input by $16$.
The value of `(((double (double double)) inc) 5)` should therefore be `21`.

We can verify this result with `mit-scheme`:
```text
1 ]=> (((double (double double)) inc) 5)

;Value: 21
```
