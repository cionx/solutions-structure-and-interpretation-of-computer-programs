# Exercise 2.63

> Each of the following two procedures converts a binary tree to a list.
> ```scheme
> (define (tree->list-1 tree)
>   (if (null? tree)
>       '()
>       (append (tree->list-1 (left-branch tree))
>               (cons (entry tree)
>                     (tree->list-1 (right-branch tree))))))
>
> (define (tree->list-2 tree)
>   (define (copy-to-list tree result-list)
>     (if (null? tree)
>         result-list
>         (copy-to-list (left-branch tree)
>                       (cons (entry tree)
>                             (copy-to-list (right-branch tree)
>                                           result-list)))))
>   (copy-to-list tree '()))
> ```
> 1. Do the two procedures produce the same result for every tree?
>    If not, how do the results differ?
>    What lists do the two procedures produce for the trees in Figure 2.16?
>
> 2. Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree with $n$ elements to a list?
>    If not, which one grows more slowly?

---

### 1.

The list `(tree->list-1 tree)` has as entries the vertices of `tree`, in increasing order.
The same is true for `(tree->list-2 tree)`, whence the two procedures give the same result.

All three trees in Figure 2.16 result in the same list `(1 3 5 7 9 11)`.



### 2.

#### The first procedure

Let $t$ be a tree with left branch $t_1$ of size $n_1$ and right branch $t_2$ of size $n_2$.
Let $s_1$ and $s_2$ be the number of steps that the procedure `tree->list-1` needs to for the arguments $t_1$ and $t_2$ respectively.

- The procedures `entry`, `left-branch`, `right-branch` and `cons` take a constant amount of steps.

- The evaluations of `(tree->list-1 t1)` and `(tree->list-1 t2)` take $s_1$ and $s_2$ many steps.

- The final call to `append` takes an amount of steps that is linear in the length of its first argument, and thus linear in $n_1$.

We thus find that we need $C_1 n_1 + s_1 + s_2 + C_0$ many steps, where $C_1$ and $C_0$ are constants that do not depend on the given trees.

If $T(n)$ is the number of steps required for a balanced binary tree with $n$ elements, then we find that
$$
  T(n)
  = C_1 \frac{n}{2} + 2 T (n / 2) + C_0
  = 2 T(n / 2) + \frac{C_1}{2} n + C_0 \,.
$$
The term $\frac{C_1}{2} n + C_0$ is linear in $n$, whence it follows that $T(n)$ is in $Θ(n \log(n))$.[^1]

[^1]: Compare this to the situation for divide-and-conquer sorting algorithms, where we have $T(n) = 2 T(n / 2) + \text{linear time for merging the two lists}$, and get a running time of $Θ(n \log(n))$.

#### The second procedure

The following operations are responsible for the running time of evaluating `(tree->list-2 t)`:

- the check `null?`,
- the procedure `cons`, and
- the three procedures `entry` (which is equivalent to `car`), `left-branch` (which is equivalent to `cadr`) and `right-branch` (which is equivalent to `caddr`).

Each of these operations takes a constant amount of time, and each operation is called once for every entry in `t`.
This already gives $Θ(n)$ many steps.

We also call `null?` twice for every leaf of `t`.
But there cannot be more than $n$ leaves, so these are no more than $2n$ further calls to `null?`.

We thus get a total running time of $Θ(n)$.
