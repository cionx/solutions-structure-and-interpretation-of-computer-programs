# Exercise 2.19

> Consider the change-counting program of section 1.2.2.
> It would be nice to be able to easily change the currency used by the program, so that we could compute the number of ways to change a British pound, for example.
> As the program is written, the knowledge of the currency is distributed partly into the procedure `first-denomination` and partly into the procedure `count-change` (which knows that there are five kinds of U.S. coins).
> It would be nicer to be able to supply a list of coins to be used for making change.
>
> We want to rewrite the procedure `cc` so that its second argument is a list of the values of the coins to use rather than an integer specifying which coins to use.
> We could then have lists that defined each kind of currency:
> ```scheme
> (define us-coins (list 50 25 10 5 1))
>
> (define uk-coins (list 100 50 20 10 5 2 1 0.5))
> ```
> We could then call `cc` as follows:
> ```scheme
> (cc 100 us-coins)
> 292
> ```
> To do this will require changing the program `cc` somewhat.
> It will still have the same form, but it will access its second argument differently, as follows:
> ```scheme
> (define (cc amount coin-values)
>   (cond ((= amount 0) 1)
>         ((or (< amount 0) (no-more? coin-values)) 0)
>         (else
>          (+ (cc amount
>                 (except-first-denomination coin-values))
>             (cc (- amount
>                    (first-denomination coin-values))
>                 coin-values)))))
> ```
> Define the procedures `first-denomination`, `except-first-denomination`, and `no-more?` in terms of primitive operations on list structures.
> Does the order of the list `coin-values` affect the answer produced by `cc`?
> Why or why not?

---

We can define the required procedures as follows:
```scheme
(define (first-denomination coin-values)
  (car coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (no-more? coin-values)
  (null? coin-values))
```

The procedure `cc` is based on the following mathematics:

> Given a real number $x$ and a set $S$ of positive real numbers, let $C(x, S)$ be the number of ways of writing $x$ as a sum of elements of $S$.
  (For example, $C(100, \{ 50, 25, 10, 5, 1 \}) = 292$.)
> More precisely, $C(x, S)$ is defined as the number of functions $f \colon S \to ℕ_0$ satisfying the condition $x = \sum_{s ∈ S} f(s) s$.
>
> The following boundary conditions hold:
>
> - $C(0, S) = 1$.
>
> - If $x$ is negative then $C(x, S) = 0$.
>
> - $C(x, ∅) = 0$ if $x$ is nonzero.
>
> For every element $s$ of $S$, the following recursion relation holds:
>
> - $C(x, S) = C(x - s, S) + C(x, S ∖ \{ s \})$.

The order of the list `coin-values` doesn’t matter since in the mathematical formulation we are dealing with a set, which imposes no order on its elements.
