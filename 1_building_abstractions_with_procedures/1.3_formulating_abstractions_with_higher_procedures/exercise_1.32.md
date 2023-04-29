# Exercise 1.32

> 1.  Show that `sum` and `product` (Exercise 1.31) are both special cases of a still more general notion called `accumulate` that combines a collection of terms, using some general accumulation function:
>     ```scheme
>     (accumulate combiner null-value term a next b)
>     ```
>
>     `accumulate` takes as arguments the same term and range specifications as `sum` and `product`, together with a `combiner` procedure (of two arguments) that specifies how the current term is to be combined with the accumulation of the preceding terms and a `null-value` that specifies what base value to use when the terms run out.
>     Write `accumulate` and show how `sum` and `product` can both be defined as simple calls to `accumulate`.
>
>
> 2.  If your `accumulate` procedure generates a recursive process, write one that generates an iterative process.
>     If it generates an iterative process, write one that generates a recursive process.



### 1.

The procedure `accumulate` can be implemented as follows:
```scheme
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))
```
The procedures `sum` and `product` can be implemented in terms of `accumulate` as follows:
```scheme
(define (sum term a next b)
  (define (add x y) (+ x y))
  (accumulate add 0 term a next b))

(define (product term a next b)
  (define (multiply x y) (* x y))
  (accumulate multiply 1 term a next b))
```



### 2.

The above implementation of `accumulate` generates a recursive process, whereas the following implementation generates an iterative process:
```scheme
(define (accumulate combiner null-value term a next b)
  (define (iter a b result)
    (if (> a b)
        result
        (iter (next a) b
              (combiner result (term a)))))
  (iter a b null-value))
```
