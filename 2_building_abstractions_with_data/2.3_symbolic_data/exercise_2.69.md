# Exercise 2.69

> The following procedure takes as its argument a list of symbol-frequency pairs (where no symbol appears in more than one pair) and generates a Huffman encoding tree according to the Huffman algorithm.
> ```scheme
> (define (generate-huffman-tree pairs)
>   (successive-merge (make-leaf-set pairs)))
> ```
> `make-leaf-set` is the procedure given above that transforms the list of pairs into an ordered set of leaves.
> `successive-merge` is the procedure you must write, using `make-code-tree` to successively merge the smallest-weight elements of the set until there is only one element left, which is the desired Huffman tree.
> (This procedure is slightly tricky, but not really complicated.
> If you find yourself designing a complex procedure, then you are almost certainly doing something wrong.
> You can take significant advantage of the fact that we are using an ordered set representation.)



The leafs in the list `(make-leaf-set pairs)` are ordered in increasing weight.
We merge the first two entries of this list with `make-code-tree`, and then insert the resulting tree back into the remaining list with `adjoin-set`;
the resulting list of trees will again be ordered in increasing weight.
We repeat this process until only one tree is left in the list;
this is then the computed Huffman tree.
```scheme
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge ordered-tree-list)
  (define (merge otl)
    (let ((t1 (car otl))
          (all-but-1 (cdr otl)))
      (if (null? all-but-1)
          t1
          (let ((t2 (car all-but-1))
                (all-but-2 (cdr all-but-1)))
            (merge
             (adjoin-set (make-code-tree t1 t2)
                         all-but-2))))))
  (if (null? ordered-tree-list)
      '()
      (merge ordered-tree-list)))
```
We can test our code with the tree from Exercise 2.67:
```scheme
(define pairs '((A 4) (B 2) (C 1) (D 1)))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(newline)
(display "Sample tree")
(newline)
(display sample-tree)

(newline)
(display "Computed tree")
(newline)
(display (generate-huffman-tree pairs))
```
```text
Sample tree
((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)
Computed tree
((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)
```
