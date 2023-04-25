# Exercise 2.32

> We can represent a set as a list of distinct elements, and we can represent the set of all subsets of the set as a list of lists.
> For example, if the set is `(1 2 3)`, then the set of all subsets is `(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))`.
> Complete the following definition of a procedure that generates the set of subsets of a set and give a clear explanation of why it works:
> ```scheme
> (define (subsets s)
>   (if (null? s)
>       (list nil)
>       (let ((rest (subsets (cdr s))))
>         (append rest (map ⟨??⟩ rest)))))
> ```



We replace `nil` (which is non-standard, and for example not supported by mit-scheme 12.1), by `'()`.

Given a set $S$ and an element $x$ of $S$, we can consider two kinds of subsets of $S$:
those that contain $x$, and those that don’t.
Let $\mathcal{P}(S)$ be the power set of $S$, and let
$$
  \mathcal{P}_{x, 1}(S) ≔ \{ T ⊆ S \mid x ∈ T \} \,,
  \quad
  \mathcal{P}_{x, 0}(S) ≔ \{ T ⊆ S \mid x ∉ T \} \,.
$$
We make three observations:

- The power set $\mathcal{P}(S)$ is the disjoint union of its two subsets $\mathcal{P}_{x, 1}(S)$ and $\mathcal{P}_{x, 0}(S)$.

- We have a bijection between $\mathcal{P}_{x, 1}(S)$ and $\mathcal{P}_{x, 0}(S)$ given by
  $$
    \mathcal{P}_{x, 0}(S) \longrightarrow \mathcal{P}_{x, 1}(S) \,,
    \quad
    T \longmapsto T ∪ \{ x \} \,.
  $$

- The set $\mathcal{P}_{x, 0}(S)$ is the power set of $S ∖ x$.

Therefore, altogether,
$$
  \begin{aligned}
  \mathcal{P}(S)
  &= \mathcal{P}_{x, 0}(S) \amalg \mathcal{P}_{x, 1}(S) \\
  &= \mathcal{P}_{x, 0}(S) \amalg \{ T ∪ \{ x \} \mid T ∈ \mathcal{P}_{x, 0}(S) \} \\
  &= \mathcal{P}(S ∖ x) \amalg \{ T ∪ \{ x \} \mid T ∈ \mathcal{P}(S ∖ x) \} \,. \\
  \end{aligned}
$$

This calculation tells us how the power set of $S$ can be computed from the power set of the slightly smaller set $S ∖ x$.
We can repeat this process until we are left with computing the power set of the empty set.
But this power set is simply $\{ ∅ \}$.

This procedure is implemented by the following procedure:
```scheme
(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest
                (map (lambda (t)
                       (cons (car s) t))
                     rest)))))
```
