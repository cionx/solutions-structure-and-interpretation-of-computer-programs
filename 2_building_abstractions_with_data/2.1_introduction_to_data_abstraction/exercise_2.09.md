# Exercise 2.9

> The _width_ of an interval is half of the difference between its upper and lower bounds.
> The width is a measure of the uncertainty of the number specified by the interval.
> For some arithmetic operations the width of the result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the width of the combination is not a function of the widths of the argument intervals.
> Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals being added (or subtracted).
> Give examples to show that this is not true for multiplication or division.

---

### Addition

Suppose we are given two intervals $x = [x_1, x_2]$ and $y = [y_1, y_2]$.
Then $x + y = [x_1 + y_1, x_2 + y_2]$ and therefore
$$
  \begin{aligned}
  \operatorname{width}(x + y)
  &=
  \frac{(x_2 + y_2) - (x_1 + y_1)}{2} \\[0.7em]
  &=
  \frac{x_2 + y_2 - x_1 - y_1}{2} \\[0.7em]
  &=
  \frac{x_2 - x_1}{2} + \frac{y_2 - y_1}{2} \\[0.7em]
  &=
  \operatorname{width}(x) + \operatorname{width}(y) \,.
  \end{aligned}
$$



### Subtraction

We observe that for every interval $x = [x_1, x_2]$, the negated interval $- x = [-x_2, -x_1]$ has the same width as $x$:
$$
  \operatorname{width}(- x)
  =
  \frac{- x_1 - (- x_2)}{2}
  =
  \frac{x_2 - x_1}{2}
  =
  \operatorname{width}(x) \,.
$$

It follows for every two intervals $x$ and $y$ that
$$
  \operatorname{width}(x - y)
  =
  \operatorname{width}(x + (- y))
  =
  \operatorname{width}(x) + \operatorname{width}(- y)
  =
  \operatorname{width}(x) + \operatorname{width}(y) \,.
$$



### Multiplication

We need to show that there cannot exist a function $f$ such that
$$
  \operatorname{width}(x ⋅ y)
  =
  f( \operatorname{width}(x), \operatorname{width}(y) )
$$
for all intervals $x$ and $y$.
This is equivalent to saying that there exist intervals $x_1, x_2, y_1, y_2$ such that $\operatorname{width}(x_1) = \operatorname{width}(x_2)$ and $\operatorname{width}(y_1) = \operatorname{width}(y_2)$, but $\operatorname{width}(x_1 ⋅ y_1) ≠ \operatorname{width}(x_2 ⋅ y_2)$.

We can consider the interval $x ≔ [0, 1]$ and the two intervals $y_1 ≔ [0, 1]$ and $y_2 ≔ [1, 2]$ with
$$
  \operatorname{width}(y_1) = \frac{1}{2} = \operatorname{width}(y_2) \,.
$$
We have $x ⋅ y_1 = [0, 1]$ and $x ⋅ y_2 = [0, 2]$, and thus
$$
  \operatorname{width}(x ⋅ y_1)
  =
  \operatorname{width}([0, 1])
  =
  \frac{1}{2}
  ≠
  1
  =
  \operatorname{width}([0, 2])
  =
  \operatorname{width}(x ⋅ y_2) \,.
$$



### Division

We use the same approach as for multiplication, but this time we consider the intervals $x_1 ≔ [0, 2]$, $x_2 ≔ [2, 4]$ and $y = [1, 2]$.
We have $x_1 / y = [0, 2]$ and $x_2 / y = [1, 4]$, and therefore
$$
  \operatorname{width}(x_1 / y)
  =
  \operatorname{width}([0, 2])
  =
  1
  ≠
  \frac{3}{2}
  =
  \operatorname{width}([1, 4])
  =
  \operatorname{width}(x_2 / y) \,.
$$
But we also have $\operatorname{width}(x_1) = 1 = \operatorname{width}(x_2)$.
