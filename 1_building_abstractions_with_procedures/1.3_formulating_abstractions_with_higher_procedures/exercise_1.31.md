# Exercise 1.31

> 1.  The `sum` procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures.
>     Write an analogous procedure called `product` that returns the product of the values of a function at points over a given range.
>     Show how to define `factorial` in terms of `product`.
>     Also use `product` to compute approximations to $π$ using the formula
>     $$
>       \frac{π}{4}
>       =
>       \frac{2 ⋅ 4 ⋅ 4 ⋅ 6 ⋅ 6 ⋅ 8 \dotsm}{3 ⋅ 3 ⋅ 5 ⋅ 5 ⋅ 7 ⋅ 7 \dotsm} \,.
>     $$
>
>
> 2.  If your `product` procedure generates a recursive process, write one that generates an iterative process.
>     If it generates an iterative process, write one that generates a recursive process.



### 1.

The procedure `product` can be implemented as follows:
```scheme
(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))
```

We can then implement `factorial` as follows:
```scheme
(define (factorial n)
  (define (id x) x)
  (define (inc x) (+ 1 x))
  (product id 1 inc n))
```

For the approximation of $π$, we arrange the given formula as
$$
  \frac{π}{4}
  =
  \frac{2 ⋅ 4 ⋅ 4 ⋅ 6 ⋅ 6 ⋅ 8 \dotsm}{3 ⋅ 3 ⋅ 5 ⋅ 5 ⋅ 7 ⋅ 7 \dotsm}
  =
  \frac{2 ⋅ 4}{3 ⋅ 3}\, ⋅ \,\frac{4 ⋅ 6}{5 ⋅ 5}\, ⋅ \,\frac{6 ⋅ 8}{7 ⋅ 7} \dotsm
$$
This rearrangement leads to the following procedure:
```scheme
(define (pi-approx n)
  (define (term k)
    (/ (* k (+ 2.0 k))
       (* (+ 1 k) (+ 1 k))))
  (define (inc-2 x) (+ 2 x))
  (* (product term 2 inc-2 (* 2 n))
     4))
```
In the third line, we use a floating point number to force the overall result of `pi-approx` to be a floating point.



### 2.

The above implementation of `product` generates a recursive process.
The following implementation generates an iterative process:
```scheme
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))
```
