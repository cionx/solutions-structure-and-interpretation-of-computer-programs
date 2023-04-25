# Exercise 2.31

> Abstract your answer to Exercise 2.30 to produce a procedure `tree-map` with the property that `square-tree` could be defined as
```scheme
(define (square-tree tree) (tree-map square tree))
```



We can write the described procedure `tree-map` as follows:
```scheme
(define (tree-map f tree)
  (if (list? tree)
      (map (lambda (t) (tree-map f t)) tree)
      (f tree)))
```
