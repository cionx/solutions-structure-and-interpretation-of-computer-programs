# Exercise 2.57

> Extend the differentiation program to handle sums and products of arbitrary numbers of (two or more) terms.
> Then the last example above could be expressed as
> ```scheme
>   (deriv '(* x y (+ x 3)) 'x)
> ```
> Try to do this by changing only the representation for sums and products, without changing the `deriv` procedure at all.
> For example, the `addend` of a sum would be the first term, and the `augend` would be the sum of the rest of the terms.



We start off with some auxiliary procedures.
To define `sum?` and `product?`, we will use an abstraction:
```scheme
(define (operation? op exp)
  (and (pair? exp) (eq? (car exp) op)))
```
We will also use an abstract procedure for combining two expressions with respect to a specified operation:
```scheme
(define (combine symbolic-op number-op x y)
  (cond ((and (number? x) (number? y)) (number-op x y))
        ((and (operation? symbolic-op x)
              (operation? symbolic-op y))
         (cons symbolic-op (append (cdr x) (cdr y))))
        ((operation? symbolic-op x)
         (cons symbolic-op (append (cdr x) (list y)))) ; allow for noncomm.
        ((operation? symbolic-op y)
         (cons symbolic-op (cons x (cdr y))))
        (else (list symbolic-op x y))))
```
The procedures so far can only construct larger expressions, whereas selectors can also break down expressions into smaller pieces.
To make sure that we don’t have lists of length one, we will use the following auxiliary procedure:
```scheme
(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (format-operation op items)
  (cond ((singleton? items) (car items))
        (else (cons op items))))
```
These auxiliary procedures lead to the following definition of abstract selectors.
```scheme

(define (get-first items)
  (cadr items))

(define (get-rest items)
  (format-operation (car items) (cddr items)))
```

We can now implement sums as follows:
```scheme
(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? exp)
  (operation? '+ exp))

(define (addend sum)
  (get-first sum))

(define (augend sum)
  (get-rest sum))
```

Products are similarly implemented as follows:
```scheme
(define (make-product x y)
  (cond ((or (=number? x 0) (=number? y 0)) 0)
        ((=number? x 1) y)
        ((=number? y 1) x)
        (else (combine '* * x y))))

(define (product? exp)
  (operation? '* exp))

(define (multiplier product)
  (get-first product))

(define (multiplicand product)
  (get-rest product))
```
