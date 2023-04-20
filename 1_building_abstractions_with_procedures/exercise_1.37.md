# Exercise 1.37

> An infinite \newterm{continued fraction} is an expression of the form
> $$
>   f = \cfrac{N_1}{D_1 + \cfrac{N_2}{D_2 + \cfrac{N_3}{D_3 + \dotsb}}} \,.
> $$
> As an example, one can show that the infinite continued fraction expansion with the $N_i$ and the $D_i$ all equal to $1$ produces $1 / ϕ$, where $ϕ$ is the golden ratio (described in Section 1.2.2).
> One way to approximate an infinite continued fraction is to truncate the expansion after a given number of terms.
> Such a truncation—a so-called _$k$-term finite continued fraction_—has the form
> $$
>   \cfrac{N_1}{D_1 + \cfrac{N_2}{ ⋱ + \cfrac{N_k}{D_k}}} \,.
> $$
> Suppose that `n` and `d` are procedures of one argument (the term index $i$) that return the $N_i$ and $D_i$ of the terms of the continued fraction.
> Define a procedure `cont-frac` such that evaluating `(cont-frac n d k)` computes the value of the $k$-term finite continued fraction.
> Check your procedure by approximating $1 / ϕ$ using
> ```scheme
> (cont-frac (lambda (i) 1.0)
>            (lambda (i) 1.0)
>            k)
> ```
> for successive values of `k`.
> How large must you make `k` in order to get an approximation that is accurate to $4$ decimal places?
>
> If your `cont-frac` procedure generates a recursive process, write one that generates an iterative process.
> If it generates an iterative process, write one that generates a recursive process.



### a.

We can implement the procedure `cont-frac` as follows:
```scheme
(define (cont-frac n d k)
  (define (aux n d i k)
    (if (> i k)
        0.
        (/ (n i)
           (+ (d i)
              (aux n d (+ 1 i) k)))))
  (aux n d 1 k))
```

To compute $1 / ϕ$ up to a certain precision, it would be good to know that the digits of $1 / ϕ$ are.
Luckily, we know that $ϕ = 1 + 1 / ϕ$, and thus
$$
  1 / ϕ = ϕ - 1 ≈ 0.618033988749…
$$
We will now use the following auxiliary procedure:
```scheme
(define (one-over-phi k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))
```
For $k = 11$ we get four correct digits.
```text
1 ]=> (one-over-phi 9)

;Value: .6181818181818182

1 ]=> (one-over-phi 10)

;Value: .6179775280898876

1 ]=> (one-over-phi 11)

;Value: .6180555555555556
```
However, already for $k = 10$ the error has four zeroes after the period.



### b.

The above implementation of `cont-frac` generates a recursive procedure.
The following implementation generates an iterative procedure:
```scheme
(define (cont-frac n d k)
  (define (aux n d i result)
    (if (<= i 0)
        result
        (let ((new-result
                (/ (n i) (+ (d i) result))))
          (if (<= i 0)
              result
              (aux n d (- i 1) new-result)))))
  (aux n d k 0.0))
```
