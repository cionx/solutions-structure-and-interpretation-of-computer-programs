# Exercise 2.5

> Show that we can represent pairs of nonnegative integers using only numbers and arithmetic operations if we represent the pair $a$ and $b$ as the integer that is the product $2^a 3^b$.
> Give the corresponding definitions of the procedures `cons`, `car`, and `cdr`.

---

The numbers 2 and 3 are two distinct prime numbers.
It follows for any two integers $a$ and $b$ that $a$ and $b$ are already uniquely determined by the single number $2^a 3^b$.

The procedure `cons` can be implemented as follows:
```scheme
(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))
```
To implement `car` and `cdr` we use an auxiliary function that determines how often a prime factor occurs in a number:
```scheme
(define (multiplicity p n)
  (define (divides? d x)
    (= 0 (remainder x d)))
  (define (iter p n counter)
    (if (divides? p n)
        (iter p (/ n p) (+ counter 1))
        counter))
  (iter p n 0))

(define (car n)
  (multiplicity 2 n))

(define (cdr n)
  (multiplicity 3 n))
```

We can test our code in `mit-scheme`:
```text
1 ]=> (define z (cons 3 4))

;Value: z

1 ]=> z

;Value: 648

1 ]=> (car z)

;Value: 3

1 ]=> (cdr z)

;Value: 4
```
