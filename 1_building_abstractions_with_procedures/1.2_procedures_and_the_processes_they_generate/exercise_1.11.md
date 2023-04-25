# Exercise 1.11

> A function $f$ is defined by the rule
> $$
>   f(n)
>   =
>   \begin{cases}
>     n                                   & \text{if $n < 3$,} \\
>     f(n - 1) + 2 f(n - 2) + 3 f(n - 3)  & \text{if $n ≥ 3$.}
>   \end{cases}
> $$
> Write a procedure that computes $f$ by means of a recursive process.
> Write a procedure that computes $f$ by means of an iterative process.



We can write these procedures as follows:
```scheme
(define (f-recursive n)
  (if (< n 3)
      n
      (+ (f-recursive (- n 1))
         (* 2 (f-recursive (- n 2)))
         (* 3 (f-recursive (- n 3))))))

(define (f-iterative-iter a b c counter)
  (define (next a b c)
    (+ a (* 2 b) (* 3 c)))
  (if (<= counter 0)
      a
      (f-iterative-iter (next a b c) a b (- counter 1))))

(define (f-iterative n)
  (if (< n 3)
      n
      (f-iterative-iter 2 1 0 (- n 2))))
```
