# Exercise 2.71

> Suppose we have a Huffman tree for an alphabet of $n$ symbols, and that the relative frequencies of the symbols are $1, 2, 4, …, 2^{n - 1}$.
> Sketch the tree for $n = 5$;
> for $n = 10$.
> In such a tree (for general $n$) how many bits are required to encode the most frequent symbol?
> The least frequent symbol?


The sequence of frequencies $(f_n)_n$ is given by $f_n = 2^n$ for every $n ≥ 0$, and therefore satisfies the inequality
$$
  f_0 + f_1 + f_2 + f_3 + \dotsb + f_n
  = 1 + 2 + 4 + \dotsb + 2^n
  = 2^{n + 1} - 1
  < 2^{n + 1}
  = f_{n + 1}
$$
for every $n ≥ 0$.
We denote for every $n ≥ 0$ the symbol with frequency $f_n$ by $s_n$.
It follows from the above inequality that the Huffmann tree for the weighted symbols $(s_0, f_0), …, (s_n, f_n)$ will look as follows:
```text
     *
    / \
sₙ *   *
      / \
sₙ₋₁ *   .
          .
           .
            \
             *
            / \
        s₁ *   * s₀
```
The most frequent symbol — namely $s_n$ — is encoded as `0`, whence we need only one bit.
When considering the first $n + 1$ many symbols (i.e., $s_0$ up to $s_n$), then the least frequent symbol – namely $s_0$ – will be encoded as `1111…10` with $n$ ones before the zero.
We thus need `n + 1` bits.

More generally, we need $n - k + 1$ bits to encode $s_k$.
It follows that altogether, we need
$$
  ∑_{k = 0}^n (n - k + 1) f_k
  = ∑_{k = 0}^n (n - k + 1) 2^k
  = (n + 1) ∑_{k = 0}^n 2^k - ∑_{k = 0}^n k 2^k
$$
many steps.
We have $∑_{k = 0}^n 2^k = 2^{n + 1} - 1$ and $∑_{k = 0}^n k 2^k = 2^{n + 1} n - 2^{n + 1} + 2$, so we get a total of
$$
  \begin{aligned}
    {}&
    (n + 1) (2^{n + 1} - 1) - (2^{n + 1} n - 2^{n + 1} + 2) \\
    ={}&
    n 2^{n + 1} + 2^{n + 1} - n - 1 - n 2^{n + 1} + 2^{n + 1} - 2 \\
    ={}&
    2 ⋅ 2^{n + 1} - n - 3 \\
    ={}&
    2^{n + 2} - n - 3
  \end{aligned}
$$
bits for the entire message.
