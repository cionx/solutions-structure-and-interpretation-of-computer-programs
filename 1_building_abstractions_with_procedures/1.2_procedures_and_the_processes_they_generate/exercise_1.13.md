# Exercise 1.13

> Prove that $\operatorname{Fib}(n)$ is the closest integer to $ϕ^n / \sqrt{5}$, where $ϕ = (1 + \sqrt{5}) / 2$.
> Hint:
> Let $ψ = (1 - \sqrt{5}) / 2$.
> Use induction and the definition of the Fibonacci numbers (see Section 1.2.2) to prove that $\operatorname{Fib}(n) = (ϕ^n - ψ^n) / \sqrt{5}$.



The numbers $ϕ$ and $ψ$ are the two roots of the quadratic polynomial
$$
  x^2 - x - 1 \,,
$$
whence $ϕ^2 = ϕ + 1$ and $ψ^2 = ψ + 1$.

We have the base cases
$$
  \frac{ϕ^0 - ψ^0}{\sqrt{5}}
  =
  \frac{1 - 1}{\sqrt{5}}
  =
  \frac{0}{\sqrt{5}}
  =
  0
  =
  \operatorname{Fib}(0)
$$
and
$$
  \frac{ϕ^1 - ψ^1}{\sqrt{5}}
  =
  \frac{ϕ - ψ}{\sqrt{5}}
  =
  \frac{1 + \sqrt{5} - (1 - \sqrt{5})}{2 \sqrt{5}}
  =
  \frac{2 \sqrt{5}}{2 \sqrt{5}}
  =
  1
  =
  \operatorname{Fib}(1) \,,
$$
and for $n > 2$ the induction step
$$
  \begin{aligned}
    \frac{ϕ^n - ψ^n}{\sqrt{5}}
    &=
    \frac{ϕ^{n - 2} ϕ^2 - ψ^{n - 2} ψ^2}{\sqrt{5}} \\[1em]
    &=
    \frac{ϕ^{n - 2}(ϕ + 1) - ψ^{n - 2} (ψ + 1)}{\sqrt{5}} \\[1em]
    &=
    \frac{ϕ^{n - 1} + ϕ^{n - 2} - ψ^{n - 1} - ψ^{n - 2}}{\sqrt{5}} \\[1em]
    &=
    \frac{ϕ^{n - 1} - ψ^{n - 1}}{\sqrt{5}}
    + \frac{ϕ^{n - 2} - ψ^{n - 2}}{\sqrt{5}} \\[0.5em]
    &=
    \operatorname{Fib}(n - 1) + \operatorname{Fib}(n - 2) \\
    &=
    \operatorname{Fib}(n) \,.
  \end{aligned}
$$

We have
$$
  |ψ| = \frac{|1 - \sqrt{5}|}{2} = \frac{\sqrt{5} - 1}{2} < 1 \,,
$$
and for every natural number $n$ therefore
$$
  \biggl| \operatorname{Fib}(n) - \frac{ϕ^n}{\sqrt{5}} \biggr|
  =
  \biggl| \frac{ψ^n}{\sqrt{5}} \biggr|
  =
  \frac{|ψ|^n}{\sqrt{5}}
  ≤
  \frac{1^n}{\sqrt{5}}
  =
  \frac{1}{\sqrt{5}}
  <
  \frac{1}{\sqrt{4}}
  =
  \frac{1}{2} \,.
$$
The strict inequality
$$
  \biggl| \operatorname{Fib}(n) - \frac{ϕ^n}{\sqrt{5}} \biggr|
  <
  \frac{1}{2}
$$
tells us that the integer $\operatorname{Fib}(n)$ is the closest integer to the real number $ϕ^n / \sqrt{5}$.
