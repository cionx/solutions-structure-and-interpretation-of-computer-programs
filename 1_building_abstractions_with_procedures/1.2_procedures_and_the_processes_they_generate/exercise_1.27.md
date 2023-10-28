# Exercise 1.27

> Demonstrate that the Carmichael numbers listed in Footnote 1.47 really do fool the Fermat test.
> That is, write a procedure that takes an integer $n$ and tests whether $a^n$ is congruent to $a$ modulo $n$ for every $a < n$, and try your procedure on the given Carmichael numbers.

---

We use the following code:
```scheme
(define (find-carmichael limit)
  (find-carmichael-iter 1 limit))

(define (find-carmichael-iter n limit)
  (when (carmichael? n)
    (display n)
    (newline))
  (when (<= n limit)
    (find-carmichael-iter (+ n 1) limit)))

(define (carmichael? n)
  (and (maybe-prime? n)
       (not (prime? n))))

(define (maybe-prime? n)
  (maybe-prime-iter 1 n))

(define (maybe-prime-iter a n)
  (or (>= a n)
      (and (= a (expmod a n n))
           (maybe-prime-iter (+ a 1) n))))
```

With a bit of waiting, we get the following Carmichael numbers below $10,000$:
```text
1 ]=> (find-carmichael 10000)
561
1105
1729
2465
2821
6601
8911

;Unspecified return value
```
