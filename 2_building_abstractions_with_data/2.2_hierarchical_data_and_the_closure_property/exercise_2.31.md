# Exercise 2.31

> Abstract your answer to Exercise 2.30 to produce a procedure `tree-map` with the property that `square-tree` could be defined as
```scheme
(define (square-tree tree) (tree-map square tree))
```

---

We can directly implement the described procedure `tree-map` as follows:
```scheme
(define (tree-map f tree)
  (cond ((null? tree) '()) ; '() is the empty list
        ((not (pair? tree)) (f tree)) ; leaf case
        (else (cons (tree-map f (car tree))
                    (tree-map f (cdr tree))))))
```

We can also implement `tree-map` using `map`:
```scheme
(define (tree-map f tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map f sub-tree)
             (f sub-tree)))
       tree))
```
