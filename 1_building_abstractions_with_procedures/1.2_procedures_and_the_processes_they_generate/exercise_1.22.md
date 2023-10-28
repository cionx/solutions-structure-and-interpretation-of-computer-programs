# Exercise 1.22

> Most Lisp implementations include a primitive called `runtime` that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds).
> The following `timed-prime-test` procedure, when called with an integer $n$, prints $n$ and checks to see if $n$ is prime.
> If $n$ is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.
> ```scheme
> (define (timed-prime-test n)
>   (newline)
>   (display n)
>   (start-prime-test n (runtime)))
>
> (define (start-prime-test n start-time)
>   (if (prime? n)
>       (report-prime (- (runtime) start-time))))
>
> (define (report-prime elapsed-time)
>   (display " *** ")
>   (display elapsed-time))
> ```
> Using this procedure, write a procedure `search-for-primes` that checks the primality of consecutive odd integers in a specified range.
> Use your procedure to find the three smallest primes
>
> - larger than 1000;
> - larger than 10,000;
> - larger than 100,000;
> - larger than 1,000,000.
>
> Note the time needed to test each prime.
> Since the testing algorithm has order of growth of $Θ(\sqrt{n})$, you should expect that testing for primes around 10,000 should take about $\sqrt{10}$ times as long as testing for primes around 1000.
> Do your timing data bear this out?
> How well do the data for 100,000 and 1,000,000 support the $Θ(\sqrt{n})$ prediction?
> Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

---

We write an auxiliary function to run multiple instances of `timed-prime-test` in succession.
```scheme
(define (smallest-primes n count)
  (if (> count 0)
      (begin (timed-prime-test n)
             (smallest-primes (+ n 1) (- count 1)))
      (begin (newline)
             (display "*** end ***"))))
```
We use the not-yet-introduced construction `(begin …)` to group together multiple expressions.

Computers have become much faster since the book was written, so we need _much_ larger inputs to observe non-zero times.

We start with 10,000,000,000 (1e10):
```text
1 ]=> (smallest-primes 10000000000 100)

10000000000
⋮
10000000019 *** .11999999999999922
⋮
10000000033 *** .1200000000000001
⋮
10000000061 *** .1299999999999999
⋮
10000000069 *** .1200000000000001
⋮
10000000097 *** .1200000000000001
⋮
10000000099
*** end ***
;Unspecified return value
```
It takes between 0.12 and 0.13 seconds per prime.

Next we start with 1,000,000,000,000 (1e12):
```text
1 ]=> (smallest-primes 1000000000000 100)

1000000000000
⋮
1000000000039 *** 1.2199999999999998
⋮
1000000000061 *** 1.2300000000000004
⋮
1000000000063 *** 1.2200000000000006
⋮
1000000000091 *** 1.2299999999999986
⋮
1000000000099
*** end ***
;Unspecified return value
```

Next we start with 100,000,000,000,000 (1e14):
```text
1 ]=> (smallest-primes 100000000000000 100)

100000000000000
⋮
100000000000031 *** 12.319999999999999
⋮
100000000000067 *** 12.259999999999998
⋮
100000000000097 *** 12.229999999999997
⋮
100000000000099 *** 12.199999999999996
*** end ***
;Unspecified return value
```

Finally, we start with 10,000,000,000,000,000 (1e16):
```text
1 ]=> (smallest-primes 10000000000000000 1000)

10000000000000000
⋮
10000000000000061 *** 121.82000000000005
⋮
10000000000000069 *** 124.13
⋮
10000000000000079 *** 121.66999999999996
⋮
10000000000000099 *** 123.63999999999999
⋮
10000000000000453 *** 123.44999999999993
⋮
10000000000000481 *** 118.07999999999993
⋮
10000000000000597 *** 121.79999999999995
⋮
10000000000000613 *** 121.5
⋮
10000000000000639 *** 120.15000000000009
⋮
10000000000000669 *** 122.69999999999982
⋮
10000000000000753 *** 123.02000000000021
⋮
10000000000000793 *** 124.24000000000024
⋮
10000000000000819 *** 122.66999999999962
⋮
10000000000000861 *** 122.17999999999984
⋮
10000000000000897 *** 124.30999999999995
⋮
10000000000000909 *** 120.21000000000004
⋮
10000000000000931 *** 115.80999999999995
⋮
10000000000000949 *** 115.4399999999996
⋮
10000000000000957 *** 115.57000000000016
⋮
10000000000000991 *** 115.44999999999982
⋮
10000000000000999
*** end ***
;Unspecified return value
```

We see that increasing the number $n$ by a factor of 100 increases the run time of `(timed-prime-test n)` by a factor of 10.
This supports the $Θ(\sqrt{n})$ prediction.
