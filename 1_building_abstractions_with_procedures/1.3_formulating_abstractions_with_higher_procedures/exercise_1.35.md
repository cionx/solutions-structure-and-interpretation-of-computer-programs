# Exercise 1.35

> Show that the golden ratio $ϕ$ (Section 1.2.2) is a fixed point of the transformation $x \mapsto 1 + 1 / x$, and use this fact to compute $ϕ$ by means of the `fixed-point` procedure.

---

The golden ratio $ϕ = (1 + \sqrt{5}) / 2$, as well as the number $(1 - \sqrt{5}) / 2$, is a root of the polynomial $x^2 - x - 1$.
As $ϕ$ is nonzero, we have the logical equivalences
$$
  ϕ^2 - ϕ - 1 = 0
  \iff
  ϕ^2 = ϕ + 1
  \iff
  ϕ = 1 + \frac{1}{ϕ} \,.
$$
This shows that $ϕ$ is a fixed point of the mapping $x \mapsto 1 + 1/x$.

We get an approximate value of $ϕ$ as follows:
```text
1 ]=> (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.)

;Value: 1.6180327868852458
```
