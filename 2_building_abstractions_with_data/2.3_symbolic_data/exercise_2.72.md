# Exercise 2.72

> Consider the encoding procedure that you designed in Exercise 2.68.
> What is the order of growth in the number of steps needed to encode a symbol?
> Be sure to include the number of steps needed to search the symbol list at each node encountered.
> To answer this question in general is difficult.
> Consider the special case where the relative frequencies of the $n$ symbols are as described in Exercise 2.71, and give the order of growth (as a function of $n$) of the number of steps needed to encode the most frequent and least frequent symbols in the alphabet.



The symbols in Exercise 2.68 are $s_0, s_1, …, s_n$, with $s_k$ of frequency $f_k = 2^k$.
The resulting Huffman tree looks as follows:
```text
     * {s₀, s₁, s₂, …, sₙ₋₁, sₙ}
    / \
sₙ *   * {s₀, s₁, s₂, …, sₙ₋₁}
      / \
sₙ₋₁ *   .
          .
           .
            \
             * {s₀, s₁, s₂}
            / \
        s₂ *   * {s₀, s₁}
              / \
          s₁ *   * s₀
```
Our code from Exercise 2.68 is as follows:
```scheme
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol sym tree)
  (define (encode-symbol-1 t)
    (cond ((null? t) (error "Cannot find symbol in an empty tree"))
          ((leaf? t)
           (if (eq? sym (symbol-leaf t)) '() false))
          (else (let ((left-result (encode-symbol-1 (left-branch t))))
                  (if (eq? left-result false)
                      (let ((right-result (encode-symbol-1 (right-branch t))))
                        (if (eq? right-result false)
                            false
                            (cons 1 right-result)))
                      (cons 0 left-result))))))
  (let ((result (encode-symbol-1 tree)))
    (if (eq? result false)
        (error "Cannot find symbol " sym)
        result)))
```

To encode the symbol $s_k$ with $k > 0$ we will start off as follows:

1. Determine that `t` is neither empty nor a leaf.

2. Determine the left branch `t'` of `t` and compute `(encode-symbol1 s₁ t')`.

3. Check that the result is `false`.

4. Compute the right branch `t''` of `t`.

Let $C_1$ be the number of steps needed so far.

The above steps are now repeated, but with `t''` instead of `t`.
This will take again $C_1$ many steps, as we perform the same operations in tree segments of the same shape:
```
                                                                  eq? left-result
null?    leaf?   left-branch                                          false        right-branch
  ↓        ↓          ↓                             eq?                 ↓           ↓
  *        *          *     null?  *    leaf?  *    symbols  *          *           *
 / \      / \        / \        ↓ / \       ↓ / \         ↓ / \        / \         / \
*   ⋱    *   ⋱      *   ⋱        *   ⋱       *   ⋱         *   ⋱      *   ⋱       *   ⋱
```

In total, we need $n - k$ iterations to arrive at the subtree that has $s_k$ in its left branch.
At this point, we still have to go through the first two lines.
But this time, `(eq? sym (symbol-leaf t))` is `true`, and instead of `false` we get `'()`.
Instead of descending further down in the tree, we now go back up and collect the digits `0`, `1`, `1`, …, `1` along the way.
This ascend back to the root of `t` is again a multiple of $n - k$.

Lastly, it is checked that the overall result is not `false`, which takes only a constant amount of time.

We have overall taken
$$
  \begin{aligned}
    {}&
      \underbrace{C_1 (n - k)}_{\text{getting to the correct subtree}}
    + \underbrace{\mathrm{constant}}_{\text{discovering that we found the leaf}}
    + \underbrace{C_2 (n - k) + \mathrm{constant}}_{\text{ascending to the root}}
    + \underbrace{\mathrm{constant}}_{\text{check of the end result}}
    \\[2em]
    ={}&
    C (n - k) + c_1
  \end{aligned}
$$
steps, for suitable constants $C$ and $c_2$.

The situation for the symbol $s_0$ is similar, except that we need slightly less steps.
We thus need $C n + c_2$ steps to encode $s_0$, where $c_2$ is a slighly smaller constant than $c_1$.

We find overall that encoding $s_k$ takes $Θ(n - k + 1)$ steps;
if $k = n$ (the most frequent symbol) then this is $Θ(1)$, and if $k = 0$ (the least frequency symbol) then this is $Θ(n)$;
for $k > 0$, this is $Θ(n - k)$.

To encode the entire message, we need $Θ( ∑_{k = 0}^n f_k (n - k + 1) )$ steps.
We have already seen in our computations for the last exercise that this is $Θ(2^{n + 2} - n - 3)$, and thus $Θ(2^n)$.
