# Exercises 2.14, 2.15, 2.16

### 2.14

Demonstrate that Lem is right.
Investigate the behavior of the system on a variety of arithmetic expressions.
Make some intervals $A$ and $B$, and use them in computing the expressions $A/A$ and $A/B$. 
You will get the most insight by using intervals whose width is a small percentage of the center value.
Examine the results of the computation in center-percent form (see exercise 2.12).

### 2.15

Eva Lu Ator, another user, has also noticed the different intervals computed by different but algebraically equivalent expressions.
She says that a formula to compute with intervals using Alyssa's system will produce tighter error bounds if it can be written in such a form that no variable that represents an uncertain number is repeated.
Thus, she says, `par2` is a “better” program for parallel resistances than `par1`.
Is she right?
Why?

### 2.16

Explain, in general, why equivalent algebraic expressions may lead to different answers.
Can you devise an interval-arithmetic package that does not have this shortcoming, or is this task impossible?
(Warning: This problem is very difficult.)

---

In the given example we have the two expressions
$$
  f(a, b) = \frac{1}{1/a + 1/b} \,,
  \qquad
  g(a, b, c, d) = \frac{ab}{c + d} \,,
$$
which satisfy
$$
  f(a, b) = g(a, b, a, b)
$$
for all $a$, $b$.
We have therefore for every two intervals $I$ and $J$ the equalities and inclusion
$$
  \begin{aligned}
    \frac{1}{1/I + 1/J}
    &=
    f(I, J) \\
    &=
    \{ f(a, b) \mid a ∈ I, b ∈ J \} \\
    &=
    \{ g(a, b, a, b) \mid a ∈ I, b ∈ J \} \\
    &⊆
    \{ g(a, b, c, d) \mid a ∈ I, b ∈ J, c ∈ I, d ∈ J \} \\
    &=
    g(I, J, I, J) \\[0.5em]
    &=
    \frac{I J}{I + J}
  \end{aligned}
$$
We see that in the expression $IJ / (I + J)$ both instances of $I$, and both instances of $J$, are treated as independent.
(In terms of probability theory:
instead of having the same random variable occur two times in an expression, we have two i.i.d. variables.)[^1]
This is not the case in the expression $ab / (a + b)$, where both instances of $a$, and both instances of $b$, are treated as equal.

Our above calculation shows that `par2` does indeed give a tighter bound than `par1`.

We can repeat our calculation also for other algebraically equivalent expressions.
We then find each time that it is best not to have any repeating variable.
(More generally, the more we avoid repeating variables, the better.)

We don’t know how to design an interval-arithmetic package that doesn’t suffer from this problem.

[^1]: We have for every random variable $X$ the simplification $X - X = 0$.
      But if $X$ and $Y$ are two i.i.d. random variables, then $X - Y$ cannot be simplified to $0$.
      The case of interval arithmetic is akin to the second situation.
