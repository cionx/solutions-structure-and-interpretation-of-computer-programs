# Exercise 1.28

> One variant of the Fermat test that cannot be fooled is called the _Miller--Rabin test_.
> This starts from an alternate form of Fermat’s Little Theorem, which states that if $n$ is a prime number and $a$ is any positive integer less than $n$, then $a$ raised to the $(n - 1)$th power is congruent to $1$ modulo $n$.
> To test the primality of a number $n$ by the Miller--Rabin test, we pick a random number $a < n$ and raise $a$ to the $(n - 1)$)th power modulo $n$ using the `expmod` procedure.
> However, whenever we perform the squaring step in `expmod`, we check to see if we have discovered a “nontrivial square root of $1$ modulo $n$,” that is, a number not equal to $1$ or $n - 1$ whose square is equal to $1$ modulo $n$.
> It is possible to prove that if such a nontrivial square root of $1$ exists, then $n$ is not prime.
> It is also possible to prove that if $n$ is an odd number that is not prime, then, for at least half the numbers $a < n$, computing $a^{n - 1}$ in this way will reveal a nontrivial square root of $1$ modulo $n$.
> (This is why the Miller--Rabin test cannot be fooled.)
> Modify the `expmod` procedure to signal if it discovers a nontrivial square root of $1$, and use this to implement the Miller--Rabin test with a procedure analogous to `fermat-test`.
> Check your procedure by testing various known primes and non-primes.
> Hint:
> One convenient way to make `expmod` signal is to have it return $0$.

---

We use the following code:
```scheme
;; find all primes from `from` to `to` (inclusive)
(define (find-primes from to)
  (find-primes-iter from to))

(define (find-primes-iter test limit)
  (when (<= test limit)
    (when (fast-prime? test 100)
      (display test)
      (newline))
    (find-primes-iter (+ test 1) limit)))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((milner-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

;; checks if a^(n - 1) ≡ 1 modulo n
;; for some random a between 1 and (n - 1)
(define (milner-rabin-test n)
  (define (try-it a)
    (= 1 (expmod a (- n 1) n)))
  (try-it (+ 1 (random (- n 1)))))

;; computes base^exp modulo n,
;; returns 0 if we encountered a non-trivial root of unity along the way
(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp)
         (square-check (expmod base (/ exp 2) n)
                       n))
        (else
         (remainder (* base (expmod base (- exp 1) n))
                    n))))

;; square x modulo n,
;; returns 0 if x is a non-trivial root of 1 modulo n
(define (square-check x n)
  (define result
    (remainder (square x) n))
  (if (and (= 1 result)
           (not (= x 1))
           (not (= x (- n 1))))
      0
      result))
```

We can use these procedures to determine all prime numbers below 10000:
```
1 ]=> (find-primes 2 10000)
2
3
5
7
11
13
17
19
23
29
31
37
41
43
47
53
59
61
67
71
73
79
83
89
97
101
⋮
557
563
⋮
1103
1109
⋮
1723
1733
⋮
2459
2467
⋮
2819
2833
⋮
6599
6607
⋮
9973
;Unspecified return value
```
As we can see, the (first few) Carmicheal numbers are now correctly filtered out.
