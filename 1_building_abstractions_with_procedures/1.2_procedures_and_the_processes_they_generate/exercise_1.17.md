# Exercise 1.17

> The exponentiation algorithms in this section are based on performing exponentiation by means of repeated multiplication.
> In a similar way, one can perform integer multiplication by means of repeated addition.
> The following multiplication procedure (in which it is assumed that our language can only add, not multiply) is analogous to the `expt` procedure:
> ```scheme
> (define (* a b)
>   (if (= b 0)
>       0
>       (+ a (* a (- b 1)))))
> ```
> This algorithm takes a number of steps that is linear in `b`.
> Now suppose we include, together with addition, operations `double`, which doubles an integer, and `halve`, which divides an (even) integer by 2.
> Using these, design a multiplication procedure analogous to `fast-expt` that uses a logarithmic number of steps.

---

We observe that
$$
  \begin{array}{ll}
    a ⋅ 0 = 0 \,,                 &                       \\
    a ⋅ b = (a + a) ⋅ (b / 2) \,, & \text{if $b$ is even} \\
    a ⋅ b = a + a ⋅ (b - 1)       & \text{if $b$ is odd}
  \end{array}
$$

We also require an operation `dec` that decreases its input by one, as well as the predicate `even?`.
We can then write the required procedure so that its generated process is iterative:
```scheme
;; The expression s + a * b is an invariant.
(define (*-fast-iter s a b)
  (cond ((= b 0) s)
        ((even? b)
         (*-fast-iter s (double a) (halve b)))
        (else
         (*-fast-iter (+ s a) a (dec b)))))

(define (*-fast a b)
  (*-fast-iter 0 a b))
```
