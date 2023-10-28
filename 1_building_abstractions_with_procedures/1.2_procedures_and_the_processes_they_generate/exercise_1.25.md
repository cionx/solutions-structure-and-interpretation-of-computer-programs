# Exercise 1.25

> Alyssa P. Hacker complains that we went to a lot of extra work in writing `expmod`.
> After all, she says, since we already know how to compute exponentials, we could have simply written
> ```scheme
> (define (expmod base exp m)
>   (remainder (fast-expt base exp) m))
> ```
> Is she correct?
> Would this procedure serve as well for our fast prime tester?
> Explain.

---

It is true that Alyssa’s implementation of `expmod` returns the same result as the original implementation.
That is, both procedures are extensionally equivalent.
But there should be a difference in performance.

We typically assume that elementary arithmetic operations take constant time.
However, this assumption fails for large integers:
instead, the running time of arithmetic operations depend on the number of digits of the involved numbers.

The procedure `fast-expt` will easily produce very large numbers, for which elementary arithmetic operations take an ever-growing amount of time.
Alyssa’s implementation of `expmod` will therefore produce a very large intermediate result, which may take quite a bit of time, and which will only afterwards be drastically reduced with `remainder`.

The original implementation of `expmod` tries to keep the resulting intermediate values as small of possible at all times.
This approach ensures that arithmetic operations stay fast.
The cost of this approach are additional uses of `remainder`, which should hopefully be cheaper than the slowdown caused by large number arithmetic.

Let us compare both implementations:
```scheme
(define (expmod-old base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod-old base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod-old base (- exp 1) m))
                    m))))

(define (expmod-new base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
```
More precisely, let us compute $123456789^{123456789}$ modulo $987654321$.
With `expmod-old` we get an immediate result:
```text
1 ]=> (expmod-old 123456789 123456789 987654321)

;Value: 598987215
```
For `expmod-new` we let the evaluation run for more than two hours without getting a result.
