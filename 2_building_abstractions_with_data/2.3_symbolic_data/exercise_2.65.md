# Exercise 2.65

> Use the results of Exercise 2.63 and Exercise 2.64 to give $Θ(n)$ implementations of `union-set` and `intersection-set` for sets implemented as (balanced) binary trees.



We can use Exercise 2.63 to change the representation of sets from binary search trees to ordered lists, then compute `union` and `intersection` in $Θ(n)$, and afterwards change the representation back to (balanced) binary trees by using Exercise 2.64.

We start with the operations for the representation as ordered lists:
```scheme
(define (intersection-oset set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1))
            (x2 (car set2))
            (rest1 (cdr set1))
            (rest2 (cdr set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-oset rest1 rest2)))
              ((< x1 x2)
               (intersection-oset rest1 set2))
              ((> x1 x2)
               (intersection-oset set1 rest2))))))

(define (union-oset set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1))
               (x2 (car set2))
               (rest1 (cdr set1))
               (rest2 (cdr set2)))
           (cond ((= x1 x2)
                  (cons x1 (union-oset rest1 rest2)))
                 ((< x1 x2)
                  (cons x1 (union-oset rest1 set2)))
                 ((> x1 x2)
                  (cons x2 (union-oset set1 rest2))))))))

```
We then need to be able to translate between binary trees and ordered lists:
```scheme
(define (tree->oset tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree)
                             result-list)))))
  (copy-to-list tree '()))

(define (oset->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))
```

We use an auxiliary procedure that allow us to translate procedures for ordered lists (in two arguments) to procedures for binary trees (again in two arguments):
```scheme
(define (translate f)
  (lambda (x y)
    (oset->tree (f (tree->oset x) (tree->oset y)))))
```
Finally, we get `intersection-set` and `union-set`:
```scheme
(define intersection-set (translate intersection-oset))

(define union-set (translate union-oset))
```
