# Exercise 1.21

> Use the `smallest-divisor` procedure to find the smallest divisor of each of the following numbers: $199$, $1999$, $19999$.



We get the following output (in `mit-scheme`)
```scheme
1 ]=> (smallest-divisor 199)

;Value: 199

1 ]=> (smallest-divisor 1999)

;Value: 1999

1 ]=> (smallest-divisor 19999)

;Value: 7
```
We see that both $199$ and $1999$ are prime, whereas $19999$ has $7$ as its smallest divisor.
