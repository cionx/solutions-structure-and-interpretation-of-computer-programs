# Exercise 1.11

> A function $f$ is defined by the rule $f(n) = n$ if $n < 3$ and
> $$
>   f(n)
>   =
>   f(n - 1) + 2 f(n - 2) + 3 f(n - 3) \qquad \text{if $n ≥ 3$.}
> $$
> Write a procedure that computes $f$ by means of a recursive process.
> Write a procedure that computes $f$ by means of an iterative process.

---

The following procedure computes $f$ via a recursive process:
```scheme
(define (f-recursive n)
  (if (< n 3)
      n
      (+ (f-recursive (- n 1))
         (* 2 (f-recursive (- n 2)))
         (* 3 (f-recursive (- n 3))))))
```

The following procedure computes $f$ via an iterative process:
```scheme
(define (f-iterative-iter a b c counter)
  (define (next a b c)
    (+ a (* 2 b) (* 3 c)))
  (if (= counter 0)
      a
      (f-iterative-iter (next a b c) a b (- counter 1))))

(define (f-iterative n)
  (if (< n 3)
      n
      (f-iterative-iter 2 1 0 (- n 2))))
```
