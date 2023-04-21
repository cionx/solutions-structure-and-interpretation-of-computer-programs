# Exercise 2.5

> Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations if we represent the pair $a$ and $b$ as the integer that is the product $2^a 3^b$.
> Give the corresponding definitions of the procedures `cons`, `car`, and `cdr`.



The procedure `cons` can be implemented as follows:
```scheme
(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))
```

To implement `car` and `cdr` we use an auxiliary function that determines how often a prime factor occurs in a number:
```scheme
(define (multiplicity p n)
  (define (divides? a b)
    (= 0 (remainder b a)))
  (define (iter p n counter)
    (if (divides? p n)
        (iter p (/ n p) (+ counter 1))
        counter))
  (iter p n 0))

(define (car n)
  (multiplicity 2 n))

(define (cdr n)
  (multiplicity 3 n))
