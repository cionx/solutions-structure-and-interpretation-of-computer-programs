# Exercise 2.67

> Define an encoding tree and a sample message:
> ```scheme
> (define sample-tree
>   (make-code-tree (make-leaf 'A 4)
>                   (make-code-tree
>                    (make-leaf 'B 2)
>                    (make-code-tree
>                     (make-leaf 'D 1)
>                     (make-leaf 'C 1)))))
>
> (define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
> ```
> Use the `decode` procedure to decode the message, and give the result.



The result of `(decode sample-message sample-tree)` is `(a d a b b c a)` with mit-scheme (which casts all symbol names to lowercase), and `(A D A B B C A)` with DrRacket.
The message is therefore ADABBCA.

We can also check this result by hand:
The Huffman encoding tree `sample-tree` looks as follows:
```text
({A B D C} 8) *
             / \
            /   \
     (A 4) *     * ({B D C} 4)
                / \
               /   \
        (B 2) *     * ({D C} 2)
                   / \
                  /   \
           (D 1) *     * (C 1)
```
The given message `0110010101110` is decoded as follows:
```text
     start at the root
      (A (B (D C)))                               result:
0 -> take the left branch
      A
     add A to the result and return to the root
      (A (B (D C)))                               result: A
1 -> take the right branch
      (B (D C))
1 -> take the right branch
      (D C)
0 -> take the left branch
      D
     add D to the result and return to the root
      (A (B (D C)))                               result: AD
0 -> take the left branch
      A
     add A to the result and return to the root
      (A (B (D C)))                               result: ADA
1 -> take the right branch
      (B (D C))
0 -> take the left branch
      B
     add B to the result and return to the root
      (A (B (D C)))                               result: ADAB
1 -> take the right branch
      (B (D C))
0 -> take the left branch
      B
     add B to the result and return to the root
      (A (B (D C)))                               result: ADABB
1 -> take the right branch
      (B (D C))
1 -> take the right branch
      (D C)
1 -> take the right branch
      C
     add C to the result and return to the root
      (A (B (D C)))                               result: ADABBC
0 -> take the left branch
      A
     add A to the result and return to the root
      (A (B (D C)))                               result: ADABBCA
```

