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



We also require an operation `dec` that decreases its input by one.
We can then write the required procedure in a tail-recursive way as follows:
```scheme
(define (even? n)
  (= n (double (halve n))))

;; The expression s + a * b is invariant.
(define (*-fast-iter s a b)
  (cond ((= b 0) s)
        ((even? b)
         (*-fast-iter s (double a) (halve b)))
        (else
         (*-fast-iter (+ s a) a (dec b)))))

(define (*-fast a b)
  (*-fast-iter 0 a b))
```
