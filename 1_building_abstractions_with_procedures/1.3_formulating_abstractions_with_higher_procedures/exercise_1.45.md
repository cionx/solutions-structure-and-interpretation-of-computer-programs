# Exercise 1.45

> We saw in Section 1.3.3 that attempting to compute square roots by naively finding a fixed point of $y \mapsto x / y$ does not converge, and that this can be fixed by average damping.
> The same method works for finding cube roots as fixed points of the average-damped $y \mapsto x / y^2$.
> Unfortunately, the process does not work for fourth roots---a single average damp is not enough to make a fixed-point search for $y \mapsto x / y^3$ converge.
> On the other hand, if we average damp twice (i.e., use the average damp of the average damp of $y \mapsto x / y^3$) the fixed-point search does converge.
> Do some experiments to determine how many average damps are required to compute $n$th roots as a fixed-point search based upon repeated average damping of $y \mapsto x / y^{n - 1}$.
> Use this to implement a simple procedure for computing $n$th roots using `fixed-point`, `average-damp`, and the `repeated` procedure of Exercise 1.43.
> Assume that any arithmetic operations you need are available as primitives.

---

We use the following code for computing the $n$th root of a number $x$ with the $k$-times dampening of $y \mapsto x / y^{n - 1}$.
```scheme
(define (root-damp x n k)
  (define (f y)
    (/ x (expt y (- n 1))))
  (fixed-point
    ((repeated average-damp k) f)
    1.0))
```
We are using scheme’s built-in procedure `expt` to calculate the power $y^{n - 1}$.

The following table shows how large $k$ must be for a specific $n$, according to our observations:

|  n  |  k  | Remark
| --: | --: | :-----
|   1 |   0 |
|   2 |   1 |
|   3 |   1 |
|   4 |   2 |
|   ⋮ |   ⋮ |
|   7 |   2 |
|   8 |   3 |
|   ⋮ |   ⋮ |
|  15 |   3 |
|  16 |   4 |
|   ⋮ |   ⋮ |
|  31 |   4 |
|  32 |   5 |
|   ⋮ |   ⋮ |
|  63 |   5 | fast
|  64 |   5 | slow
|  65 |   6 | fast
|   ⋮ |   ⋮ |
| 127 |   6 | fast
| 128 |   6 | slow
| 129 |   7 | fast
|   ⋮ |   ⋮ |
| 255 |   7 | fast
| 256 |   7 | slow
| 257 |   8 | fast
|   ⋮ |   ⋮ |
| 511 |   8 | fast
| 512 |   8 | somewhat slow
| 513 |   9 | fast

We see that $k$ should be chosen as $⌊ \log_2 n ⌋$.
This leads to the following procedure:
```scheme
(define (root x n)
  (define (log2 x)
    (/ (log x) (log 2)))
  (define (log2int x)
    (inexact->exact (floor (log2 x))))
  (define (f y)
    (/ x (expt y (- n 1))))
  (let ((k (log2int n)))
    (root-damp x n k)))
```
