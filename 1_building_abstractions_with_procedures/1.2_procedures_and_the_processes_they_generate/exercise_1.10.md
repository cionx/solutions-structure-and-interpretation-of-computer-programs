# Exercise 1.10

> The following procedure computes a mathematical function called Ackermann’s function.
> ```scheme
> (define (A x y)
>   (cond ((= y 0) 0)
>         ((= x 0) (* 2 y))
>         ((= y 1) 2)
>         (else (A (- x 1) (A x (- y 1))))))
> ```
> What are the values of the following expressions?
> ```scheme
>   (A 1 10)
>
>   (A 2 4)
>
>   (A 3 3)
> ```
> Consider the following procedures, where `A` is the procedure defined above:
> ```scheme
> (define (f n) (A 0 n)
>
> (define (g n) (A 1 n))
>
> (define (h n) (A 2 n))
>
> (define (k n) (* 5 n n))
> ```
> Give concise mathematical definitions for the functions computed by the procedures `f`, `g`, and `h` for positive integer values of $n$.
> For example, `(k n)` computes $5 n^2$.



We consider also the procedure `i` defined as follows:
```scheme
(define (i n) (A 3 n))
```

In the following, we denote for every integer $n$ its primitive Scheme value by $[n]$.
So, for example, `[5]` is `5`, and `[2^3 + 2]` is `10`.





### The procedure `f`

The procedure `f` doubles its input:
```text
  (f [n])
↓
  (A 0 [n])
↓
  (* 2 [n])
↓
  [2n]
```
Therefore, `(f n)` computes $2 n$.



### The function `g`

We claim that `(g n)` computes $2^n$.
We will prove this by induction.


The base case is as follows:
```text
  (g [1])
↓
  (A 1 [1])
=
  (A 1 1)
↓
  2
=
  [2]
=
  [2^1]
```
The induction step is as follows:
```text
  (g [n+1])
↓
  (A 1 [n+1])
↓
  (A 0 (A 1 (- [n+1] 1)))
↓
  (A 0 (A 1 [n]))
↑
  (A 0 (g [n]))
↓ ;induction hypothesis
  (A 0 [2^n])
↓
  (* 2 [2^n])
↓
  [2 ⋅ 2^n]
=
  [2^(n+1)]
```



### The expression `(A 1 10)`

The expression `(A 1 10)` can be understood as follows:
```text
  (A 1 10)
↑
  (g 10)
=
  (g [10])
↓
  [2^10]
=
  [1024]
=
  1024
```



### The procedure `h`

Just as the procedure `g` implements exponentiation with base $2$, the procedure `h` implements [tetration](https://en.wikipedia.org/wiki/Tetration) (i.e., iterated exponentiation) with base $2$.
We will denote tetration with [Knuth’s up-arrow notation](https://en.wikipedia.org/wiki/Knuth%27s_up-arrow_notation).

We prove the claim by induction.
The base case is as follows:
```text
  (h 1)
↓
  (A 2 1)
↓
  2
=
  [2]
=
  [2 ↑↑ 1]
```
The induction step is as follows:
```text
  (h [n+1])
↓
  (A 2 [n+1])
↓
  (A 1 (A 2 (- [n+1] 1)))
↓
  (A 1 (A 2 [n]))
↑
  (A 1 (h [n]))
↓ ;induction hypothesis
  (A 1 [2 ↑↑ n])
↑
  (g [2 ↑↑ n])
↓
  [2^(2 ↑↑ n)]
=
  [2 ↑↑ (n+1)]
```

Therefore, `(h n)` computes $2 \mathbin{↑↑} n$.


### The expression `(A 2 4)`

The expression `(A 2 4)` can be understood as follows:
```text
  (A 2 4)
↑
  (h 4)
↓
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



### The procedure `i`

Just as `f` implements multiplication, `g` implements exponentiation, and `h` implements tetration, the procedure `i` implements [pentation](https://en.wikipedia.org/wiki/Pentation) (iterated tetration) with base $2$.

We can see this by induction.
The base case is as follows:
```text
  (i 1)
↓
  (A 3 1)
↓
  2
↓
  [2]
↓
  [2 ↑↑↑ 1]
```
The induction step is as follows:
```text
  (i [n+1])
↓
  (A 3 [n+1])
↓
  (A 2 (A 3 (- [n+1] 1))
↓
  (A 2 (A 3 [n])
↓ ;induction hypothesis
  (A 2 [2 ↑↑↑ n])
↑
  (h [2 ↑↑↑ n])
↓
  [2 ↑↑ (2 ↑↑↑ n)]
=
  [2 ↑↑ (n+1)]
```

Therefore, `(i n)` computes $2 \mathbin{↑↑↑} n$.



### The expression `(A 3 3)`

The expression `(A 3 3)` can be understood as follows:
```text
  (A 3 3)
↑
  (i 3)
↓
  [2 ↑↑↑ 3]
=
  [2 ↑↑ 2 ↑↑ 2]
=
  [2 ↑↑ (2 ↑↑ 2)]
=
  [2 ↑↑ 2^2]
=
  [2 ↑↑ 4]
=
  [2^(2^(2^2))]
=
  [2^(2^4)]
=
  [2^(16)]
=
  [65536]
=
  65536
```



### Remark

More generally, `(A n m)` computes the hyperoperation $2 \mathbin{↑}^n m$.
