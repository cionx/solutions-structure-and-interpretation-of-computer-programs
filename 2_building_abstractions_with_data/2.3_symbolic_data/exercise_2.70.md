# Exercise 2.70

> The following eight-symbol alphabet with associated relative frequencies was designed to efficiently encode the lyrics of 1950s rock songs.
> (Note that the “symbols” of an “alphabet” need not be individual letters.)
>
> | Word | Freq.  |   | Word | Freq. |   | Word | Freq. |   | Word | Freq. |
> | :--- | ----:  | - | :--- | ----: | - | :--- | ----: | - | :--- | ----: |
> | A    |     2  |   | GET  |     2 |   | NA   |    16 |   | YIP  |     9 |
> | BOOM |     1  |   | JOB  |     2 |   | SHA  |     3 |   | WAH  |     1 |
>
> Use `generate-huffman-tree` (Exercise 2.69) to generate a corresponding Huffman tree, and use `encode` (Exercise 2.68) to encode the following message:
>
> > Get a job  
> > Sha na na na na na na na na  
> > Get a job  
> > Sha na na na na na na na na  
> > Wah yip yip yip yip yip yip yip yip yip  
> > Sha boom  
>
> How many bits are required for the encoding?
> What is the smallest number of bits that would be needed to encode this song if we used a fixed-length code for the eight-symbol alphabet?



we use the following code:
```scheme
(define pairs '((A 2) (BOOM 1) (GET 2) (JOB 2) (NA 16) (SHA 3) (YIP 9) (WAH 1) (SPACE 30) (LINEBREAK 5)))

(define tree (generate-huffman-tree pairs))

(define message '(Get a job
                  Sha na na na na na na na na
                  Get a job
                  Sha na na na na na na na na
                  Wah yip yip yip yip yip yip yip yip yip
                  Sha boom))

(define encoded-message (encode message tree))

(newline)
(display "Tree:")
(newline)
(display tree)
(newline)
(display "Message:")
(newline)
(display message)
(newline)
(display "Encoded message:")
(newline)
(display encoded-message)
(newline)
(display "Number of bits:")
(newline)
(display (length encoded-message))
```
We get the following output:
```text
Tree:
((leaf space 30) ((((leaf sha 3) ((leaf job 2) (leaf get 2) (job get) 4) (sha job get) 7) (leaf yip 9) (sha job get yip) 16) ((((leaf a 2) ((leaf wah 1) (leaf boom 1) (wah boom) 2) (a wah boom) 4) (leaf linebreak 5) (a wah boom linebreak) 9) (leaf na 16) (a wah boom linebreak na) 25) (sha job get yip a wah boom linebreak na) 41) (space sha job get yip a wah boom linebreak na) 71)
Message:
(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom)
Encoded message:
(1 0 0 1 1 1 1 0 0 0 1 0 0 1 0 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 1 1 1 0 0 0 1 0 0 1 0 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 0 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 1 1 0 0 0 1 1 0 0 1 1)
Number of bits:
129
```

The Huffman tree and the weight distribution looks as follows:
```text
               *                                         * 71
              / \                                       / \
       space *   *                                  30 *   * 41
                / \                                       / \
               /   \                                     /   \
              /     \                                   /     \
             /       \                                 /       \
            /         \                               /         \
           /           \                             /           \
          *             *                        25 *             * 16
         / \           / \                         / \           / \
        *   * na      *   * yip                 9 *   * 16    7 *   * 9
       / \           / \                         / \           / \
      *   *         *   *                     4 *   * 5     3 *   * 4
     / \   lb.   sha   / \                     / \               / \
  a *   *             *   *                 2 *   * 2         2 *   * 2
       / \         job     get                   / \
      *   *                                   1 *   * 1
   wah    boom
```
The encoded message is 129 bits long.

To encode a text with $n$ different symbols with a fixed-length code we need to use $⌈ \log_2 n ⌉$ many binary digits for each symbol.
It our case, this would mean 4 digits per word.
We have a total of 71 symbols, so we wound need 284 bits.
