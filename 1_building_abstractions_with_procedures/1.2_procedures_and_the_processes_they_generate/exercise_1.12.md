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



The entry of Pascal’s triangle in the $n$-row and $k$-th position from the left is the binomial coefficient $\binom{n}{k}$.
(We start counting both $n$ and $k$ from zero.)
By also setting $\binom{n}{k} = 0$ whenever $k > n$, we have the following extension of Pascal’s triangle:
```text
        1   0   0   0   0   0   . . .
      1   1   0   0   0   0
    1   2   1   0   0   0
  1   3   3   1   0   0
1   4   6   4   1   0   . . .
      . . .
```
We can compute the binomial coefficient $\binom{n}{k}$ with the following procedure:
```scheme
(define (binom n k)
  (cond ((> k n) 0)
        ((= k 0) 1)
        ((= k n) 1)
        (else (+ (binom (- n 1) (- k 1))
                 (binom (- n 1) k)))))
```
