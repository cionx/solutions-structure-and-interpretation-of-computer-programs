# Exercise 2.43

> Louis Reasoner is having a terrible time doing Exercise 2.42.
> His `queens` procedure seems to work, but it runs extremely slowly.
> (Louis never does manage to wait long enough for it to solve even the $6 × 6$ case.)
> When Louis asks Eva Lu Ator for help, she points out that he has interchanged the order of the nested mappings in the `flatmap`, writing it as
> ```scheme
> (flatmap
>  (lambda (new-row)
>    (map (lambda (rest-of-queens)
>           (adjoin-position new-row
>                            k
>                            rest-of-queens))
>         (queen-cols (- k 1))))
>  (enumerate-interval 1 board-size))
> ```
> Explain why this interchange makes the program run slowly.
> Estimate how long it will take Louis’s program to solve the eight-queens puzzle, assuming that the program in Exercise 2.42 solves the puzzle in time $T$.

---

To evaluate the code
```scheme
(flatmap
 (lambda (new-row)
   (map …
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))
```
the procedure `(lambda (new-row) (map … (queen-cols (- k 1))))` is applied to each of the integers `1, …, board-size`.
During each of these applications, the value of `(queen-cols (- k 1))` will be computed again.

---

We have tried different of estimates for finding out how much longer Louis will have to wait, but they all fail.
The following is the best we have, which is just a huge mess.

---

So to compute `(queen-cols k)` we need to compute `(queen-cols (- k 1))` a total of `board-size` times, and to compute `(queen-cols (- k 1))` we need to compute `(queen-cols (-k 2))` a total of `board-size` times, and so on.
This leads to the naive guess that Louis’s code will take around $\mathtt{(board-size)}^{\mathtt{(board-size)}}$ times as long as the original code.
But this estimate is probably far too large.

A more nuanced analysis is as follows:

For a given natural number $n$ and a natural number $k$ with $0 ≤ k ≤ n$, let

- $q(k)$ the number of ways of placing $k$ queens in the first $k$ column of an $n × n$ chess board such that the queens cannot attack one another;
in other word, the value of `(queen-cols k)` if `board-size` is $n$;

- $Q(k)$ the number of steps that the original procedure needs to compute $q(k)$, and

- $Q'(k)$ the number of steps that Louis’s procedure needs to compute $q(k)$.

We should actually write $q_n$, $Q_n$ and $Q'_n$ instead of just $q$, $Q$ and $Q'$, as these functions depend on $n$.
But we will leave out the index for readability.

We point out that $Q(0) = Q'(0)$.

To compute $q(k)$ with the original procedure, we have the following steps:

1. Compute $q(k - 1)$, taking $Q(k - 1)$ steps.

2. For every row number $i = 1, …, n$ and every entry $(q_{k - 1}, …, q_1)$ of the list $q(k - 1)$, form the pair $(i, k)$ and add it to the list $(q_{k - 1}, …, q_1)$, resulting in the new list $((i, k), q_{k - 1}, …, q_1)$. This requires a total of $2 n ⋅ q(k - 1)$ many `cons`.

3. For each constructed configuration $(q_k, …, q_1)$ check if it is safe.
   For example, checking that the new queen is not in the same row as any of the previous queens uses the following steps:

   1. apply the procedure `queen-row` to each $q_j$ (with `map`); resulting in $k$ uses of `car`, $k$ uses of `queen-row` (which is just `car`), and $k$ uses of `cons`;

   2. taking the first entry of the resulting list (one `car`) and compare it with (possibly) every other entry of the list ($k - 1$ uses of `car` and $k - 1$ comparisions).

   This takes a total of $5 k - 2$ basic operations;
   for simplicity, we will just use $5k$ instead.

   To check the diagonals we need a few more steps, and get $7 k$ for each of the two diagonal directions.

   We have thus a total of $19 k$ basic operations for each configuration, giving a total of $19 k n ⋅ q(k - 1)$ basic operations.

This is a total of $2 n + 19 k n = (2 + 21 k) n$ basic operations.

We have therefore
$$
  Q(k) ≈ Q(k - 1) + C_1(k - 1) ⋅ q(k - 1)
$$
for every $k = 1, …, n$, where $C_1(k - 1) = (2 + 21 k) n$, i.e., $C_1(k) = (23 + 21k) n$.
It follows that
$$
  \begin{aligned}
    Q(n)
    &≈ Q(n - 1) + C_1(n - 1) ⋅ q(n - 1) \\
    &≈ Q(n - 2) + C_1(n - 2) ⋅ q(n - 2) + C_1(n - 1) ⋅ q(n - 1) \\
    &≈ \dotsb \\
    &= C_0 + ∑_{k = 0}^{n - 1} C_1(k) q(k) \,,
  \end{aligned}
$$
where $C_0 = 1$ is the constant $Q(0)$.

We find similarly that for every $k = 1, …, n$,
$$
  Q'(k) ≈ n Q'(k - 1) + C_1(n - 1) ⋅ q(k - 1)
$$
for the same coefficient function $c$ as before.
It follows that
$$
  \begin{aligned}
    Q'(n)
    ≈{}& n Q'(n - 1)
         + C_1(n - 1) ⋅ q(n - 1) \\
    ≈{}& n^2 Q'(n - 2)
         + n C_1(n - 2) ⋅ q(n - 2)
         + C_1(n - 1) ⋅ q(n - 1) \\
    ≈{}& \dotsb \\
    ≈{}& n^n Q'(0)
         + n^{n - 1} C_1(0) q(0)
         + n^{n - 2} C_1(1) q(1) \\
     {}& + \dotsb
         + n C_1(n - 2) ⋅ q(n - 2)
         + C_1(n - 1) ⋅ q(n - 1) \\
    ={}& n^n C_0 + ∑_{k = 0}^{n - 1} n^{n - 1 - k} C_1(k) q(k) \\
    ={}& n^n \Biggl( C_0 + ∑_{k = 0}^{n - 1} \frac{ C_1(k) q(k) }{ n^{k + 1} } \Biggr) \\
  \end{aligned}
$$
where $C_0$ is the same constant as before.

We see that the factor $n^n$ is too large, as it does not take into account the difference in growth between $n ∑_{k = 0}^{n - 1} C_1(k) q(k)$ and the much slower growing $∑_{k = 0}^{n - 1} C_1(k) q(k) / n^{k + 1}$.

The factor between run times should therefore be
$$
  \begin{aligned}
  \frac{Q'(n)}{Q(n)}
  &≈
  n^n ⋅
  \frac{C_0 + ∑_{k = 0}^{n - 1} C_1(k) q(k) / n^{k + 1}}
       {C_0 + ∑_{k = 0}^{n - 1} C_1(k) q(k)}
  \\[1.5em]
  \end{aligned}
$$
Let us denote this ratio by $R(n)$.
To determine $R(n)$, we need the values $q(k)$, i.e., the values $q_n(k)$ for every $k = 0, …, n - 1$.

We modify the procedure `queen-cols` from Exercise 2.42 to compute the values $q_n(k)$:
```scheme
(define (queen-cols n k)
  (if (<= k 0)
      (list (list empty-board))
      (let ((earlier-results (queen-cols n (- k 1))))
        (cons
         (filter
          (lambda (positions)
            (safe? k positions))
          (flatmap
           (lambda (rest-of-queens)
             (map (lambda (new-row)
                    (adjoin-position new-row
                                     k
                                     rest-of-queens))
                  (enumerate-interval 1 n)))
           (car earlier-results)))
         earlier-results))))
```
We can then compute $R(n)$ as follows:
```scheme
(define (q-values n)
  (reverse (map length (queen-cols n (- n 1)))))

(define (weighted-q-values n)
  (map *
       (q-values n)
       (map (lambda (k) (* (+ 21 (* 23 k)) n))
            (enumerate-interval 0 (- n 1)))))

(define (sum items)
  (accumulate + 0 items))

(define (R n)
  (exact->inexact
    (let ((weighted-qs (weighted-q-values n)))
      (* (expt n n)
         (/
           (+ 1
              (sum (map /
                        weighted-qs
                        (map (lambda (k) (expt n (+ k 1)))
                             (enumerate-interval 0 (- n 1))))))
           (+ 1
              (sum weighted-qs)))))))
```
To measure the _actual_ run times of both the original `queens` and Louis’s version, which we call `queens-louis`, we will use the following procedure:
```scheme
(define (time loop-number f x)
  (define (iter remaining start-time)
    (if (> remaining 0)
        (begin (f x)
               (iter (- remaining 1) start-time))
        (- (runtime) start-time)))
  (/ (iter loop-number (runtime))
     loop-number))
```

We get the following results (with run time measured in seconds).

|  `n` | run time `(queens n)` | run time `(queens-louis n)` | factor | `(R n)` | factor / `(R n)` |
| ---: | --------------------: | --------------------------: | -----: | ------: | ---------------: |
|   5  |                 0.002 |                       0.082 |     41 |    18.8 |            2.181 |
|   6  |                 0.010 |                       1.350 |    135 |    61.7 |            2.188 |
|   7  |                 0.043 |                      25.766 |    599 |   255.2 |            2.345 |
|   8  |                 0.204 |                     571.900 |   2803 |  1114.8 |            2.514 |
|   9  |                 0.995 |                             |        |         |                  |
|  10  |                 5.011 |                             |        |         |                  |
|  11  |                27.722 |                             |        |         |                  |

We see that we underestimate the required time by a factor of roughly $2.5$ for board of size $8 × 8$.
We also see that this error-factor increases as the board-size increases.

However, it should be noted that our calculated factor is _much_ better than the naive $8^8 = 16777216$.

We didn’t fill out more entries for `queens-louis` since `(queens-louis 9)` would have needed multiple hours to compute.
For `(queens 12)` mit-scheme informs us that it’s “out of memory” (even though there is still plenty of RAM available).

---

We have looked for solutions to this problem online, but found only contradictory and (mainly) incomplete answers.
We found the following answers:

- The naive factor of $n^n$, which is $16777216$ for $n = 8$.
  - https://www.timwoerner.de/posts/sicp/exercises/2/43/ (Tim Wörner)
  - https://zthomae.github.io/sicp/c2e43.html (zthomae)
  - http://community.schemewiki.org/?sicp-ex-2.43, first post (jpath)

- A factor of $n^n / n!$, which is roughly $416$ for $n = 8$.
  - http://community.schemewiki.org/?sicp-ex-2.43, second post (aQuaYi.com)

- A factor of $n^{n-1} / n!$, which is roughly $52$ for $n = 8$.
 - http://community.schemewiki.org/?sicp-ex-2.43, sixth post (nave)

- A factor of $n^n / n^4 = n^{n - 4}$ for $n > 4$, and practically $1$ otherwise, which is a factor of $4096$ for $n = 8$.
  - http://community.schemewiki.org/?sicp-ex-2.43, fifth post (Alyssa P. Hacker)

- Louis’s code has a run time of $T^8$, so a factor of $T^7$.
  - https://github.com/CosVVeLL/sicp/blob/master/doc/Chapter%202/Exercise%202.43.md (CosWeLL)

- A factor of roughly $550$.
  - https://wernerdegroot.wordpress.com/2015/08/01/sicp-exercise-2-43/ (Werner de Groot)

The last link performs an analysis similar to our own.
Both Alyssa P. Hacker and Werner de Gratt claim that they results ($52$ and $550$ respectively) match their observed run times.
