# Exercise 1.7

> The `good-enough?` test used in computing square roots will not be very effective for finding the square roots of very small numbers.
> Also, in real computers, arithmetic operations are almost always performed with limited precision.
> This makes our test inadequate for very large numbers.
> Explain these statements, with examples showing how the test fails for small and large numbers.
> An alternative strategy for implementing `good-enough?` is to watch how `guess` changes from one iteration to the next and to stop when the change is a very small fraction of the guess.
> Design a square-root procedure that uses this kind of end test.
> Does this work better for small and large numbers?

---

### Small numbers

The current implementation of `good-enough?` considers only the absolute error, but not the relative one.
For small numbers, this can lead `sqrt` to give results that are far too large.

| `x`   | `(sqrt x)`          |
|:------|:--------------------|
| 1.0   | 1.0                 |
| 0.1   | 0.316245562280389   |
| 0.01  | 0.10032578510960605 |
| 1e-3  | 0.04124542607499115 |
| 1e-4  | 0.03230844833048122 |
| 1e-5  | 0.03135649010771716 |
| 1e-6  | 0.03126065552544528 |
| 1e-7  | 0.03125106561775382 |
| 1e-8  | 0.03125010656242753 |
| 1e-9  | 0.03125001065624928 |
| 1e-10 | 0.03125000106562499 |


We can see that at some point, the output of `sqrt x` stays nearly the same; more precisely, if $x$ equals $10^{-n}$, then the output seemss to be roughly
$$
  0.03125 + 1.0656 ⋅ 10^{-(n-1)} \,.
$$
It thus seems to reckon that for $x$ small enough, the output of `(sqrt x)` should be roughly
$$
  \frac{1}{32} + 10.656 x \,.
$$

### Digression

We can derive this approximation from first principles:
for every non-negative real number $x$, let $f_x$ be the improvement function
$$
  f_x \colon ℝ ∖ \{ 0 \} \longrightarrow ℝ ∖ \{ 0 \} \,,
  \quad
  g \longmapsto \frac{1}{2}\biggl( g + \frac{x}{g} \biggr) \,.
$$
The value of `(sqrt x)` is (up to the limitations of machine arithmetic) of the form
$$
  \underbrace{ f_x( \dotsb f_x( f_x }_{n_x}(1) ) \dotsb )
  =
  f_x^{n_x}(1)
  \,,
$$
where $n_x$ is the number of iterations, which depends on $x$, and where $1$ is the starting guess.
The number $n_x$ has the property
$$
  | f_x^{n_x}(1)^2 - x | < 0.001,
$$
and it is the least number with this property.

For the special case of $x = 0$, the function $f_0$ is simply given by division by $2$:
$$
  f_0(g) = \frac{g}{2} \,.
$$
Therefore, $f_0^m(1) = 1/2^m$ for every $m ≥ 0$, and we have
$$
  | f_0^m(1)^2 - 0 | < 0.001
  \iff
  \frac{1}{2^{2m}} < 0.001
  \iff
  2^{2m} > 1000
  \iff
  4^m > 1000
  \iff
  m ≥ 5 \,.
$$
The number of iterations $n_0$ is therefore $5$, i.e., $n_0 = 5$.
We also note that
$$
  |f_0^4(1)^2 - 0| = \frac{1}{2^{2 ⋅ 4}} = \frac{1}{2^8} = \frac{1}{256}
$$
is _strictly_ larger than $0.001$.

We claim that $n_x = 5$ whenever $x$ is sufficiently small.
That is, the number of iterations $n_x$ is the same for all sufficiently small $x$.

> _Proof of the claim._
> We can see from the explicit formula for $f_x$ and by induction that the $m$-th guess $f_x^m(1)$ is a rational function in $x$, for every $m ≥ 0$.
> Consequently, $f_x^m(1)$ is continuous in $x$ (smooth, even).
> Consequently, the $m$-th error function $e_m(x) ≔ |f_x^m(1)^2 - x|$ is continuous in $x$, for every $m ≥ 0$.
> We already know that $e_4(0) > 0.001$ and $e_5(0) < 0.001$.
> So by continuity of $e_4$ and $e_5$, there exists some (possibly rather small) radius $δ > 0$ such that $e_4(x) > 0.001$ and $e_5(x) < 0.001$ for every $x$ in $[0, δ)$.
> This tells us that
> $$
>   n_x = 5 \qquad \text{for every $x ∈ [0, δ)$} \,.
> $$

The value of `(sqrt x)` is therefore (up to the limitations of machine arithmetic) given by
$$
  f_x^5(1)
  =
  f_x( f_x( f_x( f_x( f_x(1) ) ) ) )
$$
for every $x$ in $[0, δ)$.
Let us abbreviate this expression as $s(x)$.

As noted before, $s(x)$ is a rational function in $x$.
Therefore, it is smooth, and we have
$$
  s(x) ≈ s(0) + s'(0) x
$$
for sufficiently small $x$.
The value $s(0)$ is $f_0^5(1) = 1 / 2^5 = 1 / 32$.
We don’t know how to compute $s'(0)$ in a smart way, so we will enlist the help of the computer.
More precisely, we will use Sympy:
```python
from sympy import Symbol, simplify

x = Symbol('x')
g = Symbol('g')

fx = (g + x / g)/2

g0 = 1
g1 = simplify( fx.subs(g, g0) )
g2 = simplify( fx.subs(g, g1) )
g3 = simplify( fx.subs(g, g2) )
g4 = simplify( fx.subs(g, g3) )
g5 = simplify( fx.subs(g, g4) )

print(g5.diff(x).subs(x, 0))
```
The result is $341/32 = 10.65625$, which fits the previous observed value of $10.656$.

For interest, we can also get the fully simplified and expanded expression for $s(x)$ as $a(x) / b(x)$ for two polynomials $a$ and $b$:
```python
from sympy import fraction, expand

a, b = fraction(g5)

print(expand(a))
print(expand(b))
```
The resulting polynomials are
$$
\begin{aligned}
  a(x) ={}& x^{16} + 496 x^{15} + 35960 x^{14} + 906192 x^{13} + 10518300 x^{12} \\
        {}& + 64512240 x^{11} + 225792840 x^{10} + 471435600 x^9 + 601080390 x^8 \\
        {}& + 471435600 x^7 + 225792840 x^6 + 64512240 x^5 + 10518300 x^4 \\
        {}& + 906192 x^3 + 35960 x^2 + 496 x + 1
\end{aligned}
$$
and
$$
\begin{aligned}
  b(x) ={}& 32 (x^{15} + 155 x^{14} + 6293 x^{13} + 105183 x^{12} + 876525 x^{11} \\
        {}& + 4032015 x^{10} + 10855425 x^9 + 17678835 x^8 + 17678835 x^7 \\
        {}& + 10855425 x^6 + 4032015 x^5 + 876525 x^4 + 105183 x^3 \\
        {}& + 6293 x^2 + 155 x + 1) \,.
\end{aligned}
$$

Overall, the value of `(sqrt x)` is precisely $a(x) / b(x)$ for sufficiently small $x$, up to the errors of machine arithmetic.



### Large numbers

We run into another problem with `(sqrt x)` if the input `x` becomes too large.
More precisely, the procedure `good-enough?` becomes unreliable once its arguments `guess` and `x` become too large.

For the evaluation of `(good-enough? guess x)` we compute the difference `(- (square guess) x)`.
But machine arithmetic has only limited precision.
In particular, subtraction of two large numbers of the same order of magnitude can have a noticeable margin of error, relative to the mathematically correct result.
This can lead to two potential problems:

- The difference `(- (square guess) x)` is smaller than it should be (in terms of its absolute value), leading to `(good-enough? guess x)` passing prematurely.

- The difference `(- (square guess) x)` is larger than it should be, leading to `(good-enough? guess x)` not passing even though it should.

In the first case, the absolute error between `(square x)` and the mathematically correct result is slightly greater than expected.
But the relative error is still pretty small, since we are dealing with large numbers.

But in the second case, the evaluation of `(square x)` may not terminate.
This is, for example, the case if we choose `x` as `1e46` (or larger).



### Alternative implementation

For better results, we can use a different implementation for `good-enough?`:
```scheme
(define (small-percentage? x y)
  (< (abs x)
     (* 0.0001 (abs y))))

(define (good-enough? oldguess newguess)
  (small-percentage? (- oldguess newguess) oldguess))
```

We split the procedure `sqrt-iter` into two parts:
The first part takes the arguments `guess` and `x` and produces a new guess.
The second part then takes the three arguments `oldguess`, `newguess` and `x` and determines what to do next.
The two parts will recursively call one another.

```scheme
(define (sqrt-iter-start guess x)
  (sqrt-iter-cmp guess
                 (improve guess x)
                 x))

(define (sqrt-iter-cmp oldguess newguess x)
  (if (good-enough? oldguess newguess)
      newguess
      (sqrt-iter-start newguess x)))

(define (sqrt x)
  (sqrt-iter-start 1.0 x))
```
With this new implementation, we get the following results:

| `x`    | `(sqrt x)`              |
|:-------|:------------------------|
| 1e300  | 1.0000000000084744e150  |
| 1e250  | 1.000000000003481e125   |
| 1e200  | 1.0000000000013873e100  |
| 1e150  | 1.0000000000005358e75   |
| 1e100  | 1.0000000000002003e50   |
| 1e50   | 1.0000000000000725e25   |
| 1.0    | 1.0                     |
| 1e-50  | 1.0000000000000725e-25  |
| 1e-100 | 1.0000000000002005e-50  |
| 1e-150 | 1.0000000000005359e-75  |
| 1e-200 | 1.0000000000013873e-100 |
| 1e-250 | 1.0000000000034811e-125 |
| 1e-300 | 1.0000000000084744e-150 |

However, it should be noted that the above code does not terminate if `x` is `0.0`.
Indeed, we have seen above that the sequence of guesses is then
$$
  1 \,, \quad
  \frac{1}{2} \,, \quad
  \frac{1}{4} \,, \quad
  \frac{1}{8} \,, \quad
  \dotsb      \,, \quad
  \frac{1}{2^n} \,, \quad
  \dotsb
$$
We can never reach the required ratio of $0.0001$, as the ratio will always be
$$
  \frac{ \frac{1}{2^n} - \frac{1}{2^{n+1}} }{\frac{1}{2^n}}
  =
  \frac{1/2^{n+1}}{1/2^n}
  =
  \frac{1}{2}
  =
  0.5 \,.
$$
We can circumvent this problem by checking for the very specific input of `0.`.
It is then also a good idea to check for the special input $+∞$, which in scheme is denoted as `+inf.0`.
We arrive at the following extended definition of `sqrt`:
```scheme
(define (sqrt x)
  (cond ((= x 0) 0)
        ((= x +inf.0) +inf.0)
        (else (sqrt-iter-1 1.0 x))))
```
