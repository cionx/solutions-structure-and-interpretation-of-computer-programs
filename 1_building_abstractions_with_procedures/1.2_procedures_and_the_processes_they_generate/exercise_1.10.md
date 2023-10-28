# Exercise 1.10

> The following procedure computes a mathematical function called Ackermann’s function.
> ```scheme
> (define (A x y)
>   (cond ((= y 0) 0)
>         ((= x 0) (* 2 y))
>         ((= y 1) 2)
>         (else (A (- x 1)
>                  (A x (- y 1))))))
> ```
> What are the values of the following expressions?
> ```scheme
> (A 1 10)
>
> (A 2 4)
>
> (A 3 3)
> ```
> Consider the following procedures, where `A` is the procedure defined above:
> ```scheme
> (define (f n) (A 0 n))
>
> (define (g n) (A 1 n))
>
> (define (h n) (A 2 n))
>
> (define (k n) (* 5 n n))
> ```
> Give concise mathematical definitions for the functions computed by the procedures `f`, `g`, and `h` for positive integer values of $n$.
> For example, `(k n)` computes $5 n^2$.

---

We consider also the procedure `i` defined as follows:
```scheme
(define (i n) (A 3 n))
```

In the following, we denote for every integer $n$ its primitive Scheme value by $[n]$.
So, for example, `[5]` is `5`, and `[2^3 + 2]` is `10`.



### The procedure `f`

The procedure `f` doubles its input:
We have
```text
  (f [0])
↓               definition of f
  (A 0 [0])
↓               first case
  0
=
  [2 * 0]
```
and for $n ≥ 1$ we have
```text
  (f [n])
↓               definition of f
  (A 0 [n])
↓               second case
  (* 2 [n])
↓               primitive evaluation
  [2 * n]
```
Therefore, `(f n)` computes $2 n$.



### The function `g` and the expression `(A 1 10)`

We claim that `(g n)` computes $2^n$ for every $n ≥ 1$.
We will prove this claim by induction over $n$.


The base case is as follows:
```text
  (g [1])
↓               definition of g
  (A 1 [1])
=
  (A 1 1)
↓               third case
  2
=
  [2]
=
  [2^1]
```
The induction step is as follows:
```text
  (g [n + 1])
↓                             definition of g
  (A 1 [n + 1])
↓                             else-case
  (A 0 (A 1 (- [n + 1] 1)))
↓                             primitive evaluation
  (A 0 (A 1 [n + 1 - 1]))
=
  (A 0 (A 1 [n]))
↑                             definition of g
  (A 0 (g [n]))
↓                             induction hypothesis
  (A 0 [2^n])
↓                             second case
  (* 2 [2^n])
↓                             primitive evaluation
  [2 ⋅ 2^n]
=
  [2^(n + 1)]
```

The expression `(A 1 10)` can now be understood as follows:
```text
  (A 1 10)
↑             definition of g
  (g 10)
=
  (g [10])
↓             proven characterization of g
  [2^10]
=
  [1024]
=
  1024
```



### The procedure `h` and the expression `(A 2 3)`

Just as the procedure `g` implements exponentiation (i.e., iterated multiplication) with base $2$, the procedure `h` implements [tetration](https://en.wikipedia.org/wiki/Tetration) (i.e., iterated exponentiation) with base $2$.
We prove this claim for $n ≥ 1$ by induction.
We will denote tetration with [Knuth’s up-arrow notation](https://en.wikipedia.org/wiki/Knuth%27s_up-arrow_notation).

The base case is as follows:
```text
  (h 1)
↓             definition of h
  (A 2 1)
↓             third case
  2
=
  [2]
=
  [2 ↑↑ 1]
```
The induction step is as follows:
```text
  (h [n + 1])
↓                               definition of h
  (A 2 [n + 1])
↓                               else-case
  (A 1 (A 2 (- [n + 1] 1)))
↓                               primitive evaluation
  (A 1 (A 2 [n + 1 - 1]))
=
  (A 1 (A 2 [n]))
↑                               definition of h
  (A 1 (h [n]))
↓                               induction hypothesis
  (A 1 [2 ↑↑ n])
↑                               definition of g
  (g [2 ↑↑ n])
↓                               proven characterization of g
  [2^(2 ↑↑ n)]
=
  [2 ↑↑ (n + 1)]
```

The expression `(A 2 4)` can now be understood as follows:
```text
  (A 2 4)
↑                 definition of h
  (h 4)
↓                 proven characterization of h
  [2 ↑↑ 4]
=
  [2^(2^(2^2))]
=
  [2^(2^4)]
=
  [2^16]
=
  65536
```



### The procedure `i` and the expression `(A 3 3)`

Just as `f` implements multiplication, `g` implements exponentiation, and `h` implements tetration, the procedure `i` implements [pentation](https://en.wikipedia.org/wiki/Pentation) (iterated tetration) with base $2$.
We can prove this claim by induction.

The base case for $n = 1$ is as follows:
```text
  (i 1)
↓           definition of i
  (A 3 1)
↓           third case
  2
=
  [2]
=
  [2 ↑↑↑ 1]
```
The induction step is as follows:
```text
  (i [n + 1])
↓                             definition of i
  (A 3 [n + 1])
↓                             else-case
  (A 2 (A 3 (- [n + 1] 1))
↓                             primitive evaluation
  (A 2 (A 3 [n + 1 - 1])
=
  (A 2 (A 3 [n])
↓                             induction hypothesis
  (A 2 [2 ↑↑↑ n])
↑                             definition of h
  (h [2 ↑↑↑ n])
↓                             proven characterization of h
  [2 ↑↑ (2 ↑↑↑ n)]
=
  [2 ↑↑ (n + 1)]
```

The expression `(A 3 3)` can now be understood as follows:
```text
  (A 3 3)
↑                   definition of i
  (i 3)
↓                   proven characterization of i
  [2 ↑↑↑ 3]
=
  [2 ↑↑ (2 ↑↑ 2)]
=
  [2 ↑↑ (2^2)]
=
  [2 ↑↑ 4]
=
  [2^(2^(2^2))]
=
  [2^(2^4)]
=
  [2^16]
=
  [65536]
=
  65536
```



### Remark

More generally, `(A n m)` computes the hyperoperation $2 \mathbin{↑}^n m$.
