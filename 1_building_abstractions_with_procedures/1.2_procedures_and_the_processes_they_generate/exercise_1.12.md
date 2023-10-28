# Exercise 1.12

> The following pattern of numbers is called _Pascal’s triangle_.
> ```text
>         1
>       1   1
>     1   2   1
>   1   3   3   1
> 1   4   6   4   1
>       . . .
> ```
> The numbers at the edge of the triangle are all $1$, and each number inside the triangle is the sum of the two numbers above it.
> Write a procedure that computes elements of Pascal’s triangle by means of a recursive process.

---

The entry of Pascal’s triangle in the $n$-row and $k$-th position from the left is the binomial coefficient $\binom{n}{k}$.
(We start counting both $n$ and $k$ from zero.)
We can compute the binomial coefficient $\binom{n}{k}$ via the recursion relation
$$
  \binom{n}{k} = \binom{n - 1}{k} + \binom{n - 1}{k - 1}
$$
together with the corner cases
$$
  \binom{n}{0} = 1 \,, \qquad
  \binom{n}{n} = 1 \,. \qquad
$$
(The first corner case expresses the entries on the left side of the triangle.
The second corner case expresses the entries on the right side of the triangle.
The recursion relation takes care of entries inside the triangle.)
We can thus compute the binomial coefficient $\binom{n}{k}$ with the following procedure:
```scheme
(define (binom n k)
  (cond ((= k 0) 1)
        ((= k n) 1)
        (else (+ (binom (- n 1) (- k 1))
                 (binom (- n 1) k)))))
```
