# Exercise 2.64

> The following procedure `list->tree` converts an ordered list to a balanced binary tree.
> The helper procedure `partial-tree` takes as arguments an integer $n$ and list of at least $n$ elements and constructs a balanced tree containing the first $n$ elements of the list.
> The result returned by `partial-tree` is a pair (formed with `cons`) whose `car` is the constructed tree and whose `cdr` is the list of elements not included in the tree.
> ```scheme
> (define (list->tree elements)
>   (car (partial-tree elements (length elements))))
>
> (define (partial-tree elts n)
>   (if (= n 0)
>       (cons '() elts)
>       (let ((left-size (quotient (- n 1) 2)))
>         (let ((left-result
>                (partial-tree elts left-size)))
>           (let ((left-tree (car left-result))
>                 (non-left-elts (cdr left-result))
>                 (right-size (- n (+ left-size 1))))
>             (let ((this-entry (car non-left-elts))
>                   (right-result
>                    (partial-tree
>                     (cdr non-left-elts)
>                     right-size)))
>               (let ((right-tree (car right-result))
>                     (remaining-elts
>                      (cdr right-result)))
>                 (cons (make-tree this-entry
>                                  left-tree
>                                  right-tree)
>                       remaining-elts))))))))
> ```
> 1. Write a short paragraph explaining as clearly as you can how `partial-tree` works.
>    Draw the tree produced by `list->tree` for the list `(1 3 5 7 9 11)`.
>
> 2. What is the order of growth in the number of steps required by `list->tree` to convert a list of $n$ elements?



### 1.

The procedure `partial-tree` takes two inputs:
a list of elements, called `elts`, and a non-negative integer $n$, which ought to be smaller or equal to the length of `elts`.

The procedure also has two (!) outputs:
a balanced binary tree that contains the first `n` elements of `elts`, and the trailing list segment of `elts` that consists of all the elements of `elts` not included in this binary tree;
more precisely, all elements of `elts` apart from the first `n` entries.

Technically speaking, Scheme doesn’t support procedures that output multiple results at once (as far as we’re aware).
Therefore, the procedure `partial-tree` doesn’t actually return two values, but instead a single value that is the pair consisting of the two results we described above.
This is why we need to `car` and `cdr` the output of `partial-tree` to access the results we actually care about.

The value of `(list->tree (1 3 5 7 9 11))` can be determined as follows (even though this is not the order in which `partial-tree` does these calculations):
```text
(1 3 5 7 9 11)


      5
     / \
(1 3)   (7 9 11)


      5
     / \
    1   (7 9 11)
   / \
'()   (3)


  5
 / \
1   (7 9 11)
 \
  (3)


    5
   / \
  1   (7 9 11)
   \
    3
   / \
'()   '()


  5
 / \
1   (7 9 11)
 \
  3


     5
    / \
   /   \
  /     \
 /       \
1         9
 \       / \
  3   (7)  (11)


    5
   / \
  /   \
 /     \
1       9
 \     / \
  3   7   (11)
     / \
  '()   '()


    5
   / \
  /   \
 /     \
1       9
 \     / \
  3   7   (11)


    5
   / \
  /   \
 /     \
1       9
 \     / \
  3   7   11
         /  \
      '()    '()


    5
   / \
  /   \
 /     \
1       9
 \     / \
  3   7   11
```

It should be noted that the procedure `list->tree` simply arranges the items of its input in a balanced binary tree.
It doesn’t care about the order of these items, or possible duplicates in its input list.
But _if_ the input list is sorted and contains no duplicate items, then the resulting binary tree will be a binary search tree.



### 2.

We can already see that the number of steps to evaluate `(partial-tree elts k)` does only depend on $k$, and not on the list `elts` (but $k$ must be between zero and the length of `elts`).
We denote the number of steps by $T(k)$.

We need the following steps to evaluate `(partial-tree elts k)`:

1. Check if $k$ is zero:
   one step.

For $k = 0$ there are no further steps, and we get $T(0) = 1$.
But in general, we also need the following steps:

2. Compute `(quotient (- k 1) 2)`:
   two steps.

3. Evaluate `(patrial-tree elts k1)` for $k_1 ≔ ⌊ k/2 ⌋$:
   $T(k_1)$ steps.

4. The value of `(patrial-tree elts k1)` is a pair.
   Strip this pair apart with `car` and `cdr`:
   two steps.

5. Compute $k_2 ≔ (k - (k_1 + 1))$ from $k_1$:
   two steps.

Note that $k_2 = k_1$ if $k$ is odd, and $k_2 = k_1 + 1$ otherwise.

6. Compute `this-entry`:
   one step.

7. Evaluate `(partial-tree (cdr non-left-elts) right-size)`:
   one step for `cdr`, $T(k_2)$ steps for `partial-tree`.

8. Unpack the pair `right-result`, with `car` and `cdr`:
   two steps.

9. Combine the intermediate results with `make-tree`:
   a constant number of steps (three steps for three `cons`?).

10. A final call to `cons`:
    one step.

We get overall that $T(k) = T(k_1) + T(k_2) + C$ for a constant $C$ which doesn’t depend on $k$, and where $k_1 = ⌊ k/2 ⌋$ and $k_2 = (k - (k_1 + 1))$, i.e., $k_1 + k_2 = k - 1$.
(The value of $C$ should be $14$.)

It follows that the procedure `list->tree` is in $Θ(n)$ where $n$ is the length of its input.
