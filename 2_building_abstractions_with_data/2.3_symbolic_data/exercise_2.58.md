# Exercise 2.58

> Suppose we want to modify the differentiation program so that it works with ordinary mathematical notation, in which `+` and `*` are infix rather than prefix operators.
> Since the differentiation program is defined in terms of abstract data, we can modify it to work with different representations of expressions solely by changing the predicates, selectors, and constructors that define the representation of the algebraic expressions on which the differentiator is to operate.
>
> 1. Show how to do this in order to differentiate algebraic expressions presented in infix form, such as `(x + (3 * (x + (y + 2))))`.
>    To simplify the task, assume that `+` and `*` always take two arguments and that expressions are fully parenthesized.
>
> 2. The problem becomes substantially harder if we allow standard algebraic notation, such as `(x + 3 * (x + y + 2))`, which drops unnecessary parentheses and assumes that multiplication is done before addition.
>    Can you design appropriate predicates, selectors, and constructors for this notation such that our derivative program still works?



We refer to symbols and integers as _atoms_.
Every expression is either an atom or a list of atoms.
We will need a predicate for atoms:
```scheme
(define (atomic? expr)
  (or (number? expr)
      (variable? expr)))
```
We refer to the two symbols `'+` and `'*` as _operations_.
We will need a predicate for operations:
```scheme
(define (operation? op exp)
  (eq? op (find-lowest exp)))
```

To each atom assign a precedence:
multiplication has a higher precedence than addition, and non-operation atoms have higher precedence than operations.
(Generally speaking, expressions that contain only low-precedence atoms will need to shielded against higher-precedence operations with parentheses.
But numbers and variables, which make up the non-operation atoms, never need parentheses.
We therefore assign them the highest precedence.)
We will get the precedence of an atom from the following procedure:
```scheme
(define (precedence atom)
  (cond ((eq? atom '+) 1)
        ((eq? atom '*) 2)
        (else 3)))
```

Suppose now we are given an expression.
How do we know if this expression is supposed to be a sum, a product, or a variable/integer?
It’s actually quite easy:
we just have to non-recursively look for the atom with the lowest precedence in the entire expression.
(By _non-recursively_ we mean that we do not descend into subexpressions in our search for low-precedence atoms.
To see why we don’t do this, consider the following expression: `1 * (2 + 3) * 4`.)
We use the following procedure to find this lowest-precedence atom:
```scheme
(define (find-lowest exp)
  (define (iter lowest-so-far rest-exp)
    (if (null? rest-exp)
        lowest-so-far
        (let ((head (car rest-exp))
              (tail (cdr rest-exp)))
          (iter (if (< (precedence head)
                       (precedence lowest-so-far))
                    head
                    lowest-so-far)
                tail))))
  (cond ((null? exp)
         (error "Error: cannot find a lowest-precedence atom in an empty expression"))
        ((atom? exp) exp)
        (else (iter (car exp) (cdr exp)))))
```
We can now define the precedence of an entire expression:
```scheme
(define (total-precedence exp)
  (precedence (find-lowest exp)))
```
We have thus the following three cases:

- If the precedence of an expression is `1`, then it is a sum.

- If the precedence of an expression is `2`, then it is a product.

- If the precedence of an expression is `3`, then it is a variable or an integer.

We will now implement a procedure `combine` that combines two expressions `x` and `y` via an operation `op`.
Intuitively speaking, we want to form `(list x op y)`.
But we also need the following:

- If `op` has higher precedence than `x` (i.e., if `precedence op` is strictly larger than `total-precedence x`), then we need to make sure that `x` is surrounded by parentheses.
  In other words, we need to ensure that `x` is a list.
- If `x` has larger or equal precedence, then we don’t want parentheses around `x`.
  Moreover, if `x` is a non-atomic expression, then we need to flatten/expand `x`.
  For example, instead of `((x * y) * z)` (a list with three items whose first entry is itself a list with three items) we want `(x * y * z)` (a list with five items).
  This requires that we “unlist” the list `x`.

We will implement this behaviour via `append` and `cons`, and an auxiliary function `make-items-list`:
```scheme
(define (combine symbolic-op number-op x y)
  (if (and (number? x) (number? y))
      (number-op x y)
      (let ((p (precedence symbolic-op)))
        (define (make-items-list z)
          (cond ((< (total-precedence z) p)
                 (list (parentisize z)))
                ((atom? z) (list z))
                (else z)))
        (append (make-items-list x)
                (cons symbolic-op
                      (make-items-list y))))))
```
As can be seen, the procedure `combine` also takes care of another check:
if both `x` and `y` are numbers, then we want to directly perform the computation described by the given operation to them.
Instead of only a single `'op` we have therefore two versions:
the symbolic operator, which is either or `'+`, and the actual numeric procedure.
(It would be nicer if we only had to pass one of them to `combine`, and then automatically determine the other version.
But we don’t know how to do that.)

We will also introduce abstract procedures for the selectors.
We need to be a bit careful at this point:
we want these functions to return an expression that is either a list consisting of multiple atoms, or a single atom.
That is, we don’t want a list that contains only a single atom (i.e., a singleton).
To this end we use an auxiliary function `unpack-singleton`:
```scheme
(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (unpack-singleton item)
  (if (singleton? item) (car item) item))
```

```scheme
(define (get-first op exp)
  (define (get-first-list expression)
    (if (or (null? expression)
            (eq? op (car expression)))
        '()
        (cons (car expression)
              (get-first-list (cdr expression)))))
 (unpack-singleton (get-first-list exp)))

(define (get-rest op exp)
  (define (get-rest-list expression)
    (cond ((null? expression) '())
          ((eq? (car expression) op) (cdr expression))
          (else (get-rest-list (cdr expression)))))
  (unpack-singleton (get-rest-list exp)))
```

We now get the constructors and selectors for sums and products for free:
```scheme
(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? exp)
  (operation? '+ exp))

(define (addend sum)
  (get-first '+ sum))

(define (augend sum)
  (get-rest '+ sum))



(define (make-product x y)
  (cond ((or (=number? x 0) (=number? y 0)) 0)
        ((=number? x 1) y)
        ((=number? y 1) x)
        (else (combine '* * x y))))

(define (product? exp)
  (operation? '* exp))

(define (multiplier product)
  (get-first '* product))

(define (multiplicand product)
  (get-rest '* product))
```

We can now write polynomial expressions in the usual way:
```text
1 ]=> (deriv '(x * y * (x + 3)) 'x)

;Value: (x * y + y * (x + 3))

1 ]=> (deriv '(x * y + z) 'x)

;Value: y

1 ]=> (deriv '(x * (y + z)) 'x)

;Value: (y + z)
```
