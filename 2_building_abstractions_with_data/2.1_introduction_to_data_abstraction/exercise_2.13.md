# Exercise 2.13

> Show that under the assumption of small percentage tolerances there is a simple formula for the approximate percentage tolerance of the product of two intervals in terms of the tolerances of the factors.
> You may simplify the problem by assuming that all numbers are positive.



First off, we assume that both intervals are not centered around $0$ (because otherwise the percentage tolerance is not well-defined).
We also assume that both percentage tolerances are below $100\%$.
This assumption is equivalent to the following condition:
each interval consists either of only positive values or of negative values.
We may assume without loss of generality that both intervals consist of only positive values.

The two intervals are thus of the forms
$$
  I_1 = [(1 - p_1) c_1, \, (1 + p_1) c_1] \,,
  \quad
  I_2 = [(1 - p_2) c_2, \, (1 + p_2) c_2] \,.
$$
Consequently, the product $I_1 ⋅ I_2$ is given by
$$
  \begin{aligned}
  {}&
  [(1 - p_1) (1 - p_2) c_1 c_2, \enspace (1 + p_1) (1 + p_2) c_1 c_2] \\
  ={}&
  [(1 - p_1 - p_2 + p_1 p_2) c_1 c_2, \enspace (1 + p_1 + p_2 + p_1 p_2) c_1 c_2]
  \end{aligned}
$$
The width of $I_1 ⋅ I_2$ is therefore
$$
  \frac{(1 + p_1 + p_2 + p_1 p_2) c_1 c_2 - (1 - p_1 - p_2 + p_1 p_2) c_1 c_2}{2}
  =
  \frac{2 (p_1 + p_2) c_1 c_2}{2}
  =
  (p_1 + p_2) c_1 c_2 \,.
$$
The center of $I_1 ⋅ I_2$ is
$$
  \frac{(1 + p_1 + p_2 + p_1 p_2) c_1 c_2 + (1 - p_1 - p_2 + p_1 p_2) c_1 c_2}{2}
  =
  \frac{2 (1 + p_1 p_2) c_1 c_2}{2}
  =
  (1 + p_1 p_2) c_1 c_2 \,.
$$
The tolerance of $I_1 ⋅ I_2$ is therefore
$$
  \frac{(p_1 + p_2) c_1 c_2}{(1 + p_1 p_2) c_1 c_2}
  =
  \frac{p_1 + p_2}{1 + p_1 p_2} \,.
$$
So far we have only assumed that $p_1$ and $p_2$ are smaller than $100 \% = 1$.
But we see that, as $p_1$ and $p_2$ decrease, the tolerance $(p_1 + p_2) / (1 + p_2 p_2)$ can be approximated as $p_1 + p_2$.
(For example, if $p_1$ and $p_2$ are both $10\%$, then $(p_1 + p_2) / (1 + p_2 p_2) =  (p_1 + p_2) / 1.01 ≈ 0.99 ⋅ (p_1 + p_2)$.)
