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

---

The corresponding definition of `cdr` is as follows:
```scheme
(define (cdr z)
  (z (lambda (p q) q)))
```

Let `z` be `(cons x y)`, and let us denote the projection procedure `(lambda (p q) p)` by `π`.
Then `(π x y)` evaluates to `x`, and we have for `(car z)` the following evaluations:
```scheme
(car z)

(z π)

((lambda (m) (m x y)) π)

(π x y)

x
```
We find in the same way that `(cdr z)` evaluates to `y`.

**Remark.**
Mathematically speaking, we represent an element $(a, b)$ of the product $A × B$ via the corresponding natural transformation
$$
  \mathrm{ev}_{(a, b)}
  \colon
  \operatorname{Hom}_{\mathsf{Set}}(A × B, -)
  \longrightarrow
  \mathrm{Id}_{\mathsf{Set}} \,,
  \quad
  f
  \longmapsto
  f(a, b)
$$
It follows from Yoneda’s lemma that the assignment $(a, b) \mapsto \mathrm{ev}_{(a, b)}$ is in fact a bijection between $A × B$ and the set of natural transformations from $\operatorname{Hom}_{\mathsf{Set}}(A × B, -)$ to $\mathrm{Id}_{\mathsf{Set}}$.
