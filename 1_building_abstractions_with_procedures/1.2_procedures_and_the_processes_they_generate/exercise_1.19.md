# Exercise 1.19

> There is a clever algorithm for computing the Fibonacci numbers in a logarithmic number of steps.
> Recall the transformation of the state variables $a$ and $b$ in the `fib-iter` process of Section 1.2.2:
> $$
>   a \leftarrow a + b \,, \quad
>   b \leftarrow a \,.
> $$
> Call this transformation $T$, and observe that applying $T$ over and over again $n$ times, starting with $1$ and $0$, produces the pair $\operatorname{Fib}(n + 1)$ and $\operatorname{Fib}(n)$.
> In other words, the Fibonacci numbers are produced by applying $T^n$, the $n$th power of the transformation $T$, starting with the pair $(1, 0)$.
> Now consider $T$ to be the special case of $p = 0$ and $q = 1$ in a family of transformations $T_{pq}$, where $T_{pq}$ transforms the pair $(a, b)$ according to
> $$

>   a \leftarrow bq + aq + ap \,, \quad
>   b \leftarrow bp + aq \,.
> $$
> Show that if we apply such a transformation $T_{pq}$ twice, the effect is the same as using a single transformation $T_{p' q'}$ of the same form, and compute $p'$ and $q'$ in terms of $p$ and $q$.
> This gives us an explicit way to square these transformations, and thus we can compute $T^n$ using successive squaring, as in the `fast-expt` procedure.
> Put this all together to complete the following procedure, which runs in a logarithmic number of steps:
> ```scheme
> (define (fib n)
>   (fib-iter 1 0 0 1 n))
>
> (define (fib-iter a b p q count)
>   (cond ((= count 0) b)
>         ((even? count)
>          (fib-iter a
>                    b
>                    ⟨??⟩   ; compute p'
>                    ⟨??⟩   ; compute q'
>                    (/ count 2)))
>         (else (fib-iter (+ (* b q) (* a q) (* a p))
>                         (+ (* b p) (* a q))
>                         p
>                         q
>                         (- count 1)))))
> ```



If we regard the pair $(x, y)$ as the column vector
$$
  \begin{bmatrix} x \\ y \end{bmatrix} \,,
$$
then the transformation $T_{pq}$ is given by multiplication with the matrix
$$
  A_{pq}
  =
  \begin{bmatrix}
    p + q & q \\
    q     & p
  \end{bmatrix} \,.
$$
We observe that
$$
  \begin{aligned}
  A_{p_1 q_1} A_{p_2 q_2}
  &=
  \begin{bmatrix}
    p_1 + q_1 & q_1 \\
    q_1       & p_1
  \end{bmatrix}
  \begin{bmatrix}
    p_2 + q_2 & q_2 \\
    q_2       & p_2
  \end{bmatrix} \\
  &=
  \begin{bmatrix}
    (p_1 + q_1) (p_2 + q_2) + q_1 q_2 & (p_1 + q_1) q_2 + q_1 p_2 \\
    q_1 (p_2 + q_2) + p_1 q_2         & q_1 q_2 + p_1 p_2
  \end{bmatrix} \\
  &=
  \begin{bmatrix}
    p_1 p_2 + p_1 q_2 + q_1 p_2 + 2 q_1 q_2 & p_1 q_2 + q_1 q_2 + q_1 p_2 \\
    q_1 p_2 + q_1 q_2 + p_1 q_2             & q_1 q_2 + p_1 p_2
  \end{bmatrix} \\
  &=
  A_{p' q'}
  \end{aligned}
$$
for
$$
  p' = p_1 p_2 + q_1 q_2 \,,
  \quad
  q' = p_1 q_2 + q_1 p_2 + q_1 q_2 \,.
$$
Therefore, $T_{p_1 q_2} T_{p_2 q_2} = T_{p' q'}$ for this choice of $p'$ and $q'$.
This entails that
$$
    T_{p q}^2 = T_{p' q'}
    \quad\text{for}\quad
    p' = p^2 + q^2 \,, \quad
    q' = 2 pq + q^2 \,.
$$

We can now complete the given code:
```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (define (new-p p q)
    (+ (* p p)
       (* q q)))
  (define (new-q p q)
    (+ (* 2 p q)
       (* q q)))
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (new-p p q)
                   (new-q p q)
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
```
