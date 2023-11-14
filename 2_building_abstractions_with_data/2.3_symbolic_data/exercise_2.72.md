# Exercise 2.72

> Consider the encoding procedure that you designed in Exercise 2.68.
> What is the order of growth in the number of steps needed to encode a symbol?
> Be sure to include the number of steps needed to search the symbol list at each node encountered.
> To answer this question in general is difficult.
> Consider the special case where the relative frequencies of the $n$ symbols are as described in Exercise 2.71, and give the order of growth (as a function of $n$) of the number of steps needed to encode the most frequent and least frequent symbols in the alphabet.

---

Our code from Exercise 2.68 is as follows:
```scheme
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol sym tree)
  (define (encode-symbol-1 current-branch)
    (cond ((null? current-branch)
           (error "Cannot find symbol in an empty tree"))
          ((leaf? current-branch)
           (if (eq? sym (symbol-leaf current-branch))
               '()
               #f))
          (else
           (let ((left-result
                  (encode-symbol-1 (left-branch current-branch))))
            (if (not left-result)
                (let ((right-result
                       (encode-symbol-1 (right-branch current-branch))))
                  (if (not right-result)
                      #f
                      (cons 1 right-result)))
                (cons 0 left-result))))))
  (let ((result (encode-symbol-1 tree)))
    (if (eq? result #f)
        (error "Cannot find symbol in tree" sym)
        result)))
```
The procedure `encode-symbol`, or more precisely `encode-symbol-1`, searches recursively for the given symbol.
It visits each node in the tree exactly once, and performs a constant amount of work at each node.
(Note that we do not go through the list of symbols at each node, which would make the amount of work non-constant, and which the exercise alludes to.)
The worst-case performance is therefore $Θ(m)$, where $m$ is the number of nodes in the tree.
This worst-case occurs if we search for the right-most symbol in the tree, or if we search for a symbol that is not in the tree at all.

We observe that a Huffman tree for $n$ symbols contains $n - 1$ many non-leaf nodes.
To see this, consider how the Huffman tree is computed from the original $n$ symbols via successive merging.
Each merge combines two sets into one, and therefore reduces the total number of remaining sets by one.
As we started with $n$ sets, we will have $n - 1$ many merges.
But the non-leaf nodes in the resulting Huffman tree correspond one-to-one to these merges.
Thus, there are $n - 1$ many non-leaf nodes.

We hence find that $Θ(m) = Θ(n + (n - 1)) = Θ(2n - 1) = Θ(n)$.
The worst-case running time for looking up a symbol in a Huffman tree on $n$ symbols (with our above procedure) is therefore $Θ(n)$.

The symbols in Exercise 2.68 are $s_0, s_1, …, s_{n - 1}$, with $s_k$ of frequency $f_k = 2^k$.
The resulting Huffman tree looks as follows:
```text
       * {s₀, s₁, s₂, …, sₙ₋₁}
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

Looking up the most frequent symbol $s_{n - 1}$ takes $Θ(1)$ time (i.e., independent of $n$), and looking up the least frequent symbol $s_0$ takes $Θ(n)$ time.
(The symbol $s_0$ is right-most in the Huffman tree, and thus represents one of the worst-case scenarios.)

But it should be noted that our procedure is biased in favour of left branches:
we first search for a symbol in the left branch, then in the right branch.
If we searched right branches first, then both $s_0$ and $s_{n - 1}$ would take $Θ(n)$ time.
