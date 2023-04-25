# Exercise 1.26

> Louis Reasoner is having great difficulty doing Exercise 1.24.
> His `fast-prime?` test seems to run more slowly than his `prime?` test.
> Louis calls his friend Eva Lu Ator over to help.
> When they examine Louis’s code, they find that he has rewritten the `expmod` procedure to use an explicit multiplication, rather than calling `square`:
> ```scheme
> (define (expmod base exp m)
>   (cond ((= exp 0) 1)
>         ((even? exp)
>          (remainder (* (expmod base (/ exp 2) m)
>                        (expmod base (/ exp 2) m))
>                     m))
>         (else
>          (remainder (* base
>                        (expmod base (- exp 1) m))
>                     m))))
> ```
> “I don’t see what difference that could make,” says Louis.
> “I do.” says Eva.
> “By writing the procedure like that, you have transformed the $Θ(\log n)$ process into a $Θ(n)$ process.”
> Explain.



The original implementation of `expmod` that uses `square` needs to compute the expression `(expmod base (/ exp 2) m)` only once.
But Lois’ code needs to evaluate this expression two times, negating the improvement from the original implementation.

More precisely, let $A(n)$ be the number of arithmetic operations that Louis’ implementation of `expmod` requires to evaluate the expression `(expmod base n m)`.
We have the initial value
$$
  A(0) = 1
$$
and for $n > 1$ the recursive relation
$$
  \begin{aligned}
    A(n)
    &=
    \begin{cases}
      1 + 2 + 2 (1 + A(n / 2)) + 1 + 1 & \text{if $n$ is even,} \\
      1 + 2 + 1 + A(n - 1) + 1 + 1     & \text{if $n$ is odd.}
    \end{cases} \\[1.5em]
    &=
    \begin{cases}
      2 A(n / 2) + 7 & \text{if $n$ is even,} \\
      A(n - 1) + 6   & \text{if $n$ is odd.}
    \end{cases}
  \end{aligned}
$$

We can see by induction that
$$
  6 n ≤ A(n) \qquad \text{for every $n ≥ 0$} \,.
$$
Indeed, for $n = 0$ we have
$$
  A(0) = 1 ≥ 0 = 6 ⋅ 0 \,.
$$
For the induction step we consider $A(n)$ with $n ≥ 1$ and need to distinguish between two cases:
if $n$ is even, then
$$
  A(n)
  = 2 A(n / 2) + 7
  ≥ 2 ⋅ 6 ⋅ \frac{n}{2} + 7
  = 6 n + 7
  ≥ 6 n \,,
$$
and if $n$ is odd, then
$$
  A(n)
  = A(n - 1) + 6
  ≥ 6 (n - 1) + 6
  = 6 n - 6 + 6
  = 6 n \,.
$$

We can also see by induction that
$$
  A(n) ≤ 14 n - 7 \qquad \text{for every $n ≥ 1$} \,.
$$
Indeed, for $n = 1$ we have
$$
  A(1)
  = A(0) + 6
  = 1 + 6
  = 7
  = 14 - 7
  = 14 ⋅ 1 - 7 \,.
$$
For the induction step we consider $A(n)$ with $n ≥ 2$ and once again need to distinguish between two cases:
if $n$ is even, then
$$
  A(n)
  = 2 A(n / 2) + 7
  ≤ 2 \Bigl( 14 ⋅ \frac{n}{2} - 7 \Bigr) + 7
  = 14 n - 14 + 7
  = 14 n - 7 \,,
$$
and if $n$ is odd, then
$$
  A(n)
  = A(n - 1) + 6
  ≤ 14 (n - 1) - 7 + 6
  = 14 n - 14 - 7 + 6
  = 14 n - 15
  ≤ 14 n - 7 \,.
$$

We have thus proven that $A$ is in $Θ(n)$.
