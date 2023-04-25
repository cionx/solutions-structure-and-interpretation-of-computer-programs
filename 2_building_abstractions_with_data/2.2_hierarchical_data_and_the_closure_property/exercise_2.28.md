# Exercise 2.28

> Write a procedure `fringe` that takes as argument a tree (represented as a list) and returns a list whose elements are all the leaves of the tree arranged in left-to-right order.
> For example,
> ```scheme
> (define x (list (list 1 2) (list 3 4)))
>
> (fringe x)
> (1 2 3 4)
>
> (fringe (list x x))
> (1 2 3 4 1 2 3 4)
> ```



A basic implementation is as follows:
```scheme
(define (frindge tree)
  (define (no-list? input)
    (not (list? input)))
  (cond ((no-list? tree) (list tree))
        ((null? tree) (list))
        (else (append (frindge (car tree))
                      (frindge (cdr tree))))))
```
However, the complexity of this procedure is $Θ(n^2)$ where $n$ is the number of leaves of the input;
this worst-case performance is reached by considering the following tree:
```scheme
(list (… (list (list (list 1 2) 3) 4) …) n)
```

The following procedure has a complexity of only $Θ(n)$.
It works its way through the input tree from the right to left, and adds newly found leaves to the beginning of the already constructed list.
```scheme
(define (frindge tree)
  (define (no-list? input)
    (not (list? input)))
  (define (combine subtree right-frindge)
    (cond ((null? subtree) right-frindge)
          ((no-list? subtree) (cons subtree right-frindge))
          (else (combine (car subtree)
                         (combine (cdr subtree) right-frindge)))))
  (combine tree (list)))
```

Both implementations treat non-list values as trees consisting of a single vertex.
