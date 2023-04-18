# Exercise 1.24

> Modify the `timed-prime-test` procedure of Exercise 1.22 to use `fast-prime?` (the Fermat method), and test each of the $12$ primes you found in that exercise.
> Since the Fermat test has $Θ(\log n)$ growth, how would you expect the time to test primes near $1,000,000$ to compare with the time needed to test primes near $1000$?
> Do your data bear this out?
> Can you explain any discrepancy you find?



To use the procedure `fast-prime?`, we need to decide on the number of iterations.
It would probably make sense to make the number of iterations in `(fast-prime? n times)` depend on $n$.
More specifically, the larger $n$, the more iterations we should allow.

However, this would increase the growth from $Θ(\log n)$ to $Θ(f(n) \log n)$, where $f(n)$ is the number of iterations.
As we want to keep the growth as $Θ(\log n)$, we will therefore use a constant number of iterations.

We choose this constant as $1,000,000$.
(The run time of `fast-prime?` is proportional in the number of iterations.
If we don’t choose enough iterations, then `fast-prime?` will be evaluated nearly instantaneously.
This then prevents us from examining the run time.)


We modify the procedure `timed-prime-test` as follows:
```scheme
(define (start-prime-test n start-time)
  (if (fast-prime? n 1000000)
      (report-prime (- (runtime) start-time))))
```

Repeatedly increasing the input $n$ in `(times-prime-test n)` by a factor of $100$ should now (roughly) increase the time by the same difference each increase.

We now test the new version of `times-prime-test`.

Around $1\mathrm{e}10$ we have a run time of around $72.606$ seconds.
```text
1 ]=> (smallest-primes 10000000000 100)

10000000000
⋮
10000000019 *** 75.02999999999999
⋮
10000000033 *** 71.11000000000001
⋮
10000000061 *** 74.9
⋮
10000000069 *** 72.03999999999999
⋮
10000000097 *** 69.94999999999999
⋮
10000000099
*** end ***
;Unspecified return value
```

Around $1\mathrm{e}12$ we have a run time of around $85.555$ seconds.
```text
1 ]=> (smallest-primes 1000000000000 100)

1000000000000
⋮
1000000000039 *** 83.70000000000005
⋮
1000000000061 *** 85.19999999999999
⋮
1000000000063 *** 87.91999999999996
⋮
1000000000091 *** 85.40000000000009
⋮
1000000000099
*** end ***
;Unspecified return value
```

Around $1\mathrm{e}14$ we have a run time of around $100.0425$ seconds.
```text
1 ]=> (smallest-primes 100000000000000 100)

100000000000000
⋮
100000000000031 *** 101.38000000000001
⋮
100000000000067 *** 100.91
⋮
100000000000097 *** 97.94999999999999
⋮
100000000000099 *** 99.93
*** end ***
;Unspecified return value
```

Around $1\mathrm{e}16$ we have a run time of around $111.6525$ seconds.
```text
1 ]=> (smallest-primes 10000000000000000 100)

10000000000000000
⋮
10000000000000061 *** 111.47000000000003
⋮
10000000000000069 *** 109.88
⋮
10000000000000079 *** 113.19999999999993
⋮
10000000000000099 *** 112.06000000000006
*** end ***
;Unspecified return value
```

Around $1\mathrm{e}18$ we have a run time of around $126.8$ seconds.
```text
1 ]=> (smallest-primes 1000000000000000000 100)

1000000000000000000
⋮
1000000000000000003 *** 122.14999999999998
⋮
1000000000000000009 *** 123.06999999999994
⋮
1000000000000000031 *** 130.66000000000008
⋮
1000000000000000079 *** 131.31999999999994
⋮
1000000000000000099
*** end ***
;Unspecified return value
```

Around $1\mathrm{e}20$ we have a run time of around $160.431$ seconds.
```text
1 ]=> (smallest-primes 100000000000000000000 1000)

100000000000000000000
⋮
100000000000000000039 *** 161.51
⋮
100000000000000000129 *** 154.87000000000012
⋮
100000000000000000151 *** 161.91000000000008
⋮
100000000000000000193 *** 153.33999999999992
⋮
100000000000000000207 *** 162.5999999999999
⋮
100000000000000000301 *** 159.9300000000003
⋮
100000000000000000349 *** 159.88999999999987
⋮
100000000000000000361 *** 160.99000000000024
⋮
100000000000000000391 *** 162.23999999999978
⋮
100000000000000000393 *** 155.26000000000022
⋮
100000000000000000441 *** 160.86000000000013
⋮
100000000000000000477 *** 162.73000000000002
⋮
100000000000000000547 *** 156.16999999999962
⋮
100000000000000000559 *** 159.26999999999998
⋮
100000000000000000561 *** 156.33000000000038
⋮
100000000000000000721 *** 158.26999999999998
⋮
100000000000000000741 *** 166.48000000000002
⋮
100000000000000000753 *** 169.73000000000047
⋮
100000000000000000757 *** 164.5599999999995
⋮
100000000000000000763 *** 162.65999999999985
⋮
100000000000000000801 *** 154.89999999999964
⋮
100000000000000000853 *** 158.52000000000044
⋮
100000000000000000961 *** 156.90000000000055
⋮
100000000000000000993 *** 170.42000000000007
⋮
100000000000000000999
*** end ***
;Unspecified return value
```

We see that the increases in (average) run time are roughly $13$ seconds, $14.5$ seconds, $11.6$ seconds, $15.1$ seconds, and $33.6$ seconds.
The increase is very roughly constant, as expected from the growth type $Θ(\log n)$.

The exception is the last increase, which much larger than expected.
However, it needs to be noted that $1\mathrm{e}18$ can still be represented as an unsigned 64-bit integer, whereas this is not the case for $1\mathrm{e}20$.[^1]
This requires the Scheme interpreter to start internally using a representation for large integers.
And arithmetic operations for large integers are slower than for native 64-bit integers.

[^1]: The largest unsigned 64-bit integer is $18,446,744,073,709,551,615$, roughly $18e18$.
