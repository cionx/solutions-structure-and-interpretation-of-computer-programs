# Exercise 1.23

> The `smallest-divisor` procedure shown at the start of this section does lots of needless testing:
> After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers.
> This suggests that the values used for `test-divisor` should not be 2, 3, 4, 5, 6, …, but rather 2, 3, 5, 7, 9, …
> To implement this change, define a procedure `next` that returns 3 if its input is equal to 2 and otherwise returns its input plus 2.
> Modify the `smallest-divisor` procedure to use `(next test-divisor)` instead of `(+ test-divisor 1)`.
> With `timed-prime-test` incorporating this modified version of `smallest-divisor`, run the test for each of the 12 primes found in Exercise 1.22.
> Since this modification halves the number of test steps, you should expect it to run about twice as fast.
> Is this expectation confirmed?
> If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?

---

We use the following modified code:
```scheme
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next k)
  (if (= k 2) 3 (+ k 2)))
```



### Expected factor

In the old version of the code, each iteration of `find-divisor` (except for the last one) requires five elementary operations:

- The procedure `square` needs one multiplication.
- The predicate `(> (square test-divisor) n)` needs one comparison.
- The predicate `(divides? test-divisor n)` needs one call to `remainder`,
- as well as one comparison.
- The computation of `(+ test-divisor 1)` requires one addition.

In the modified version, the first four operations stay the same, but the last operation is replaced by _two_ operations:
a comparison in `(= k 2)` and an addition in `(+ k 2)`.
The modified version therefore requires six elementary operations.

So by switching from the old version to the modified version, each call to `find-divisor` will take 6 / 5 = 1.2 as many elementary operations, but we only need 1 / 2 = 0.5 as many calls.
The run time for the modified version should therefore be
$$
  \frac{6}{5} ⋅ \frac{1}{2} = \frac{6}{10} = 0.6
$$
times the run time of the current version.
We should therefore expect a factor of 1 / 0.6 ≈ 1.67, not 2.



### Timing the modified version

We now time the new version.

For 10,000,000,000 (1e10) we have the following results:
```text
1 ]=> (smallest-primes 10000000000 100)

10000000000
⋮
10000000019 *** .09
⋮
10000000033 *** .07999999999999999
⋮
10000000061 *** .08000000000000002
⋮
10000000069 *** .08000000000000002
⋮
10000000097 *** .09000000000000002
⋮
10000000099
*** end ***
;Unspecified return value
```

For 10,000,000,000 (1e12) we have the following results:
```text
1 ]=> (smallest-primes 1000000000000 100)

1000000000000
⋮
1000000000039 *** .7800000000000001
⋮
1000000000061 *** .79
⋮
1000000000063 *** .77
⋮
1000000000091 *** .79
⋮
1000000000099
*** end ***
;Unspecified return value
```

For 100,000,000,000,000 (1e14) we have the following results:
```text
1 ]=> (smallest-primes 100000000000000 100)

100000000000000
⋮
100000000000031 *** 7.880000000000001
⋮
100000000000067 *** 7.8100000000000005
⋮
100000000000097 *** 7.829999999999998
⋮
100000000000099 *** 7.770000000000003
*** end ***
;Unspecified return value
```

For 10,000,000,000,000,000 (1e16) we have the following results:
```text
1 ]=> (smallest-primes 10000000000000000 1000)

10000000000000000
⋮
10000000000000061 *** 79.15
⋮
10000000000000069 *** 79.65
⋮
10000000000000079 *** 79.62999999999997
⋮
10000000000000099 *** 76.82
⋮
10000000000000453 *** 76.69999999999999
⋮
10000000000000481 *** 80.86000000000001
⋮
10000000000000597 *** 79.54000000000008
⋮
10000000000000613 *** 79.12
⋮
10000000000000639 *** 79.29999999999995
⋮
10000000000000669 *** 80.19000000000005
⋮
10000000000000753 *** 79.22000000000003
⋮
10000000000000793 *** 78.78999999999996
⋮
10000000000000819 *** 78.68000000000006
⋮
10000000000000861 *** 79.98000000000002
⋮
10000000000000897 *** 79.18000000000006
⋮
10000000000000909 *** 78.56999999999994
⋮
10000000000000931 *** 79.85000000000014
⋮
10000000000000949 *** 80.90000000000009
⋮
10000000000000957 *** 80.64999999999986
⋮
10000000000000991 *** 80.01999999999998
⋮
10000000000000999
*** end ***
;Unspecified return value
```

We see that instead of a factor of 2, we have a factor of 12.3 / 7.9 ≈ 1.56.
Our estimate of 1.67 is still a bit too optimistic, but it is already more accurate than the suggested factor of 2.



### A further improvement

Our current use of the procedure `next` is pretty wasteful:
we always check if its input is 2, even though this will only be the case one time for each call to `smallest-divisor`.
We can avoid these repeated unnecessary checks as follows:

```scheme
(define (smallest-divisor n)
  (if (even? n)
      2
      (find-divisor n 3)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 2)))))
```

The run times of this improved implementation are as follows.

For 10,000,000,000 (1e10):
```text
1 ]=> (smallest-primes 10000000000 100)

10000000000
⋮
10000000019 *** .06
⋮
10000000033 *** .07
⋮
10000000061 *** .06
⋮
10000000069 *** .06
⋮
10000000097 *** .07
⋮
10000000099
*** end ***
;Unspecified return value
```

For 1,000,000,000,000 (1e12):
```text
1 ]=> (smallest-primes 1000000000000 100)

1000000000000
⋮
1000000000039 *** .6400000000000001
⋮
1000000000061 *** .6299999999999999
⋮
1000000000063 *** .6300000000000001
⋮
1000000000091 *** .6299999999999999
⋮
1000000000099
*** end ***
;Unspecified return value
```

For 100,000,000,000,000 (1e14):
```text
1 ]=> (smallest-primes 100000000000000 100)

100000000000000
⋮
100000000000031 *** 6.010000000000001
⋮
100000000000067 *** 6.050000000000001
⋮
100000000000097 *** 6.09
⋮
100000000000099 *** 6.050000000000001
*** end ***
;Unspecified return value
```

For 10,000,000,000,000,000 (1e16):
```text
1 ]=> (smallest-primes 10000000000000000 1000)

10000000000000000
⋮
10000000000000061 *** 61.359999999999985
⋮
10000000000000069 *** 62.49000000000001
⋮
10000000000000079 *** 62.48000000000002
⋮
10000000000000099 *** 61.18000000000001
⋮
10000000000000453 *** 63.06999999999999
⋮
10000000000000481 *** 62.74000000000001
⋮
10000000000000597 *** 59.66999999999996
⋮
10000000000000613 *** 58.610000000000014
⋮
10000000000000639 *** 61.960000000000036
⋮
10000000000000669 *** 60.07999999999993
⋮
10000000000000753 *** 63.620000000000005
⋮
10000000000000793 *** 62.090000000000146
⋮
10000000000000819 *** 62.93999999999983
⋮
10000000000000861 *** 62.11000000000013
⋮
10000000000000897 *** 62.549999999999955
⋮
10000000000000909 *** 62.340000000000146
⋮
10000000000000931 *** 63.319999999999936
⋮
10000000000000949 *** 61.61000000000013
⋮
10000000000000957 *** 61.409999999999854
⋮
10000000000000991 *** 62.710000000000036
⋮
10000000000000999
*** end ***
;Unspecified return value
```
We are now at a factor of roughly $12.3 / 6.1 ≈ 2$.
