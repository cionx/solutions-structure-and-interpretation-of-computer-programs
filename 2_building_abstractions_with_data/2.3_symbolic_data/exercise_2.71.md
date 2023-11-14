# Exercise 2.71

> Suppose we have a Huffman tree for an alphabet of $n$ symbols, and that the relative frequencies of the symbols are $1, 2, 4, …, 2^{n - 1}$.
> Sketch the tree for $n = 5$;
> for $n = 10$.
> In such a tree (for general $n$) how many bits are required to encode the most frequent symbol?
> The least frequent symbol?

---

The sequence of frequencies $f_0, \dotsc, f_{n - 1}$ is given by $f_k = 2^k$ for every $k$, and therefore satisfies the inequality
$$
  f_0 + f_1 + f_2 + f_3 + \dotsb + f_k
  = 1 + 2 + 4 + \dotsb + 2^k
  = 2^{k + 1} - 1
  < 2^{k + 1}
  = f_{k + 1}
$$
for every $k$.
We denote for every $k ≥ 0$ the symbol with frequency $f_k$ by $s_k$.
It follows from the above inequality that the Huffman tree for the weighted symbols $(s_0, f_0), …, (s_{n - 1}, f_{n - 1})$ will look as follows:
```text
       *
      / \
sₙ₋₁ *   .
          .
           .
            \
             *
            / \
        s₁ *   * s₀
```
The most frequent symbol, namely $s_{n - 1}$, is encoded as `0`, needing only a single bit.
More generally, $s_{n - k}$ is encoded as `1111…10` with $k - 1$ many ones before the trailing zero.
This entails that encoding $s_{n - k}$ requires $k$ bits.
In other words, $s_k$ requires $n - k$ bits to encode.
The least frequent symbol, namely $s_0$, therefore requires $n$ bits.



### Addendum

It follows that altogether we need
$$
  ∑_{k = 0}^{n - 1} (n - k) f_k
  =
  ∑_{k = 0}^{n - 1} (n - k) 2^k
  =
  n ∑_{k = 0}^{n - 1} 2^k - ∑_{k = 0}^{n - 1} k 2^k
$$
many bits to encode the entire message.
The first sum is simply
$$
  ∑_{k = 0}^{n - 1} 2^k = 2^n - 1 \,,
$$
and according to WolframAlpha we have
$$
  ∑_{k = 0}^{n - 1} k 2^k
  =
  2^n n - 2 (2^n - 1)
  =
  n 2^n - 2^{n + 1} + 2 \,.
$$
We consequently need a total of
$$
  n (2^n - 1) - (n 2^n - 2^{n + 1} + 2)
  =
  n 2^n - n - n 2^n + 2^{n + 1} - 2
  =
  2^{n + 1} - n - 2
$$
bits for the entire message.
