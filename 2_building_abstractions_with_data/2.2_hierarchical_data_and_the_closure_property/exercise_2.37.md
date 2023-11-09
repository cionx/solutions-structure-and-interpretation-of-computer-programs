# Exercise 2.37

> Suppose we represent vectors $v = (v_i)$ as sequences of numbers, and matrices $m = (m_{ij})$ as sequences of vectors (the rows of the matrix).
> For example, the matrix
> $$
> \begin{bmatrix}
>   1 & 2 & 3 & 4 \\
>   4 & 5 & 6 & 6 \\
>   6 & 7 & 8 & 9
> \end{bmatrix}
> $$
> is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))`.
> With this representation, we can use sequence operations to concisely express the basic matrix and vector operations.
> These operations (which are described in any book on matrix algebra) are the following:
>
> | operation               | explanation                                                 |
> | :---------------------- | :---------------------------------------------------------- |
> | `(dot-product v w)`     | returns the sum $∑_i v_i w_i$                               |
> | `(matrix-*-vector m v)` | returns the vector $t$, where $t_i = ∑_j m_{ij} v_j$;       |
> | `(matrix-*-matrix m n)` | returns the matrix $p$, where $p_{ij} = ∑_k m_{ik} n_{kj}$; |
> | `(transpose m)`         | returns the matrix $n$, where $n_{ij} = m_{ji}$.            |
>
> We can define the dot product as
> ```scheme
> (define (dot-product v w)
>   (accumulate + 0 (map * v w)))
> ```
> Fill in the missing expressions in the following procedures for computing the other matrix operations.
> (The procedure `accumulate-n` is defined in Exercise 2.36.)
> ```scheme
> (define (matrix-*-vector m v)
>   (map ⟨??⟩ m))
>
> (define (transpose mat)
>   (accumulate-n ⟨??⟩ ⟨??⟩ mat))
>
> (define (matrix-*-matrix m n)
>   (let ((cols (transpose n)))
>     (map ⟨??⟩ m)))
> ```

---

Suppose that an $(m × n)$-matrix $A$ has row vectors $a_1, \dotsc, a_m$.
Given a column vector $x$ of size $n$, we can form the product $A x$.
The $i$-th entry of this product is the matrix product $a_i x$ (a row vector times a column vector, which gives a scalar), which can equivalently be described as the dot-product of the transpose of $a_i$ with $x$, i.e., the product $a_i^{\mathsf{t}} ⋅ x$.
We do not distinguish between row vectors and column vectors, and can therefore implement matrix-vector-multiplication as follows:
```scheme
(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v))
       m))
```

We can compute the $i$th row of the transpose $A^{\mathsf{t}}$ by combining the $i$th column of $A$ into a list.
We hence combine the rows of $A$ via `accumulate-n` and `cons`.
```scheme
(define (transpose mat)
  (accumulate-n cons '() mat))
```

Lastly, to implement matrix-matrix-multiplication, suppose that $A$ and $B$ are two matrices such that $A B$ is defined (i.e., the width of $A$ equals the height of $B$).
If $a_1, \dotsc, a_m$ are the rows of $A$, then the $i$-th row of $AB$ is the vector-matrix-product $a_i B$.
As we do not distinguish between row vectors and column vectors, we can compute the row vector $a_i B$ as the column vector $(a_i B)^{\mathsf{t}} = B^{\mathsf{t}} a_i^{\mathsf{t}}$.
This means that we multiply $B^{\mathsf{t}}$ and $a_i$ via the procedure `matrix-*-vector`.

```scheme
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row)) m)))
```
