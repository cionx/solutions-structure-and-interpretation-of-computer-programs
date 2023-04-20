# Exercise 1.33

> You can obtain an even more general version of `accumulate` (Exercise 1.32) by introducing the notion of a filter on the terms to be combined.
> That is, combine only those terms derived from values in the range that satisfy a specified condition.
> The resulting `filtered-accumulate` abstraction takes the same arguments as accumulate, together with an additional predicate of one argument that specifies the filter.
> Write `filtered-accumulate` as a procedure.
> Show how to express the following using `filtered-accumulate`:
>
> 1. the sum of the squares of the prime numbers in the interval $a$ to $b$ (assuming that you have a `prime?` predicate already written).
>
> 2. the product of all the positive integers less than $n$ that are relatively prime to $n$ (i.e., all positive integers $i < n$ such that $\operatorname{gcd}(i, n) = 1$).



### The procedure `filtered-accumulate`

We can implement the procedure `filtered-accumulate` as follows:
```scheme
(define (filter-accumulate filter combiner null-value term a next b)
  (define (new-result a b result)
    (if (filter a)
        (combiner result (term a))
        result))
  (define (iter a b result)
    (if (> a b)
        result
        (iter (next a) b (new-result a b result))))
  (iter a b null-value))
```

Just as we implemented `sum` and `product` in terms of `accumulate`, we can then also introduce procedures `sum-filter` and `product-filter`:
```scheme
(define (filter-sum filter term a next b)
  (define (add x y) (+ x y))
  (filter-accumulate filter add 0 term a next b))

(define (filter-product filter term a next b)
  (define (multiply x y) (* x y))
  (filter-accumulate filter multiply 1 term a next b))
```



### 1.

The required procedure can be implemented as follows:
```scheme
(define (sum-prime-squares a b)
  (filter-sum prime? square a inc b))

(define (prime? n)
  (if (< n 2)
      false
      (= n (smallest-divisor n))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (inc test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x) (* x x))

(define (inc x) (+ 1 x))
```



### 2.

The described procedure can be implemented as follows:
```scheme
(define (product-coprime n)
  (define (id x) x)
  (define (coprime? a) (= 1 (gcd a n)))
  (filter-product coprime? id 2 inc n))
```
