# Exercise 2.58

> Suppose we want to modify the differentiation program so that it works with ordinary mathematical notation, in which `+` and `*` are infix rather than prefix operators.
> Since the differentiation program is defined in terms of abstract data, we can modify it to work with different representations of expressions solely by changing the predicates, selectors, and constructors that define the representation of the algebraic expressions on which the differentiator is to operate.
>
> 1. Show how to do this in order to differentiate algebraic expressions presented in infix form, such as `(x + (3 * (x + (y + 2))))`.
>    To simplify the task, assume that `+` and `*` always take two arguments and that expressions are fully parenthesized.
>
> 2. The problem becomes substantially harder if we allow standard algebraic notation, such as `(x + 3 * (x + y + 2))`, which drops unnecessary parentheses and assumes that multiplication is done before addition.
>    Can you design appropriate predicates, selectors, and constructors for this notation such that our derivative program still works?

---

We refer to symbols and integers as _atoms_.
Every _expression_ is either an atom or a list of expressions, which we then call a _combination_.
We will need a predicate for atoms:
```scheme
(define (atom? expr)
  (or (number? expr) (variable? expr)))
```
We refer to the two symbols `'+` and `'*` as _(symbolic) operations_.

To each expression we assign a precedence:
multiplication has a higher precedence than addition, and non-operation expressions have a higher precedence than operations.
For example, in `3 * x + 2` the lowest-precedence expression is `+`, which indicates that the expression is to be treated as a sum.
In `3 * x * y` the lowest-precedence expression is `*`, which indicates that the expression is to be treated as a product.
(Generally speaking, expressions that contain low-precedence atoms will need to be shielded against higher-precedence operations with parentheses.
But numbers, variables, and combinations, which make up the non-operation expressions, don’t need additional parentheses.
We therefore assign them the highest precedence.)
We will get the precedence of an expression from the following procedure:
```scheme
(define (precedence expr)
  (cond ((and (atom? expr) (eq? expr '+)) 1)
        ((and (atom? expr) (eq? expr '*)) 2)
        (else 3)))
```

Suppose now we are given an expression.
How do we know if this expression is supposed to be a sum, a product, or a variable/integer?
It’s actually quite easy:
we just have to non-recursively look for the atom with the lowest precedence in the entire expression.
(By _non-recursively_ we mean that we do not descend into subexpressions in our search for low-precedence atoms.
To see why we don’t do this, consider the following expression: `1 * (2 + 3) * 4`.
This expression is a product, so we want the lowest-precedence operation in this expression to be multiplication.)
We use the following procedure to find this lowest-precedence atom:
```scheme
;; Finds the item with the lowest precende;
;; if multiple items have lowest precedence,
;; then the first find is returned.
(define (find-lowest expr)
  (define (iter lowest-so-far rest-combination)
    (if (null? rest-combination)
        lowest-so-far
        (let ((head (car rest-combination))
              (tail (cdr rest-combination)))
          (let ((new-lowest (if (< (precedence head)
                                   (precedence lowest-so-far))
                                head
                                lowest-so-far)))
            (iter new-lowest tail)))))
  (cond ((null? expr)
         (error "Error: cannot find a lowest-precedence atom in an empty expression"))
        ((atom? expr) expr)
        (else (iter (car expr) (cdr expr)))))
```
We can now define the precedence of an entire expression:
```scheme
(define (total-precedence expr)
  (precedence (find-lowest expr)))

```
We have thus the following three cases:

- If the precedence of an expression is `1`, then it is a sum.

- If the precedence of an expression is `2`, then it is a product.

- If the precedence of an expression is `3`, then it is a variable, integer, or combination.

We can check if an expression is a sum or product with the following procedure:
```scheme
(define (operation? op expr)
  (eq? op (find-lowest expr)))
```

We will now implement a procedure `combine` that combines two expressions `x` and `y` via an operation `op`.
Intuitively speaking, we want to form `(list x op y)`.
But we also need to consider the following:

- If `op` has higher precedence than `x` (i.e., if `(precedence op)` is strictly larger than `(total-precedence x)`), then we need to make sure that `x` is surrounded by parentheses.
  In other words, we need to ensure that `x` is wrapped inside a `list`.

- If `x` has larger or equal precedence, then we don’t want parentheses around `x`.
  Moreover, if `x` is a combination, then we need to flatten/expand `x`.
  (For example, instead of `'((x * y) * z)` (a list with three items whose first entry is itself a list with three items) we want `'(x * y * z)` (a list with five items).)
  This requires that we “delist” the list `x`.

We will implement this behaviour via `append` and `cons`, and an auxiliary function `make-items-list` that adds some parentheses that are then removed by `append`.
```scheme
(define (parentisize expr)
  (if (pair? expr) expr (list expr)))

(define (combine symbolic-op number-op x y)
  (define (make-items-list z)
    (cond ((< (total-precedence z)
              (precedence symbolic-op))
           (list (parentisize z)))
          ((atom? z) (list z))
          (else z)))
  (if (and (number? x) (number? y))
      (number-op x y)
      (append (make-items-list x)
              (cons symbolic-op
                    (make-items-list y)))))
```
As can be seen, the procedure `combine` also takes care of another check:
if both `x` and `y` are numbers, then we want to directly perform the computation described by the given operation to them.
Instead of only a single `'op` we have therefore two versions:
the symbolic operator, which is either or `'+`, and the actual numeric procedure.
(It would be nicer if we only had to pass one of them to `combine`, and then automatically determine the other version.
But we don’t know how to do that without hard-coding the possible choices.)

We will also introduce abstract procedures for the selectors.
We need to be a bit careful at this point:
we want these functions to return an expression that is either a list consisting of multiple expressions, or a single expression.
That is, we don’t want a list that contains only a single atom (i.e., a singleton).
To this end we use an auxiliary function `unpack-singleton`:
```scheme
(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (unpack-singleton item)
  (if (singleton? item) (car item) item))
```

Let’s say we want the first summand in the expression `x * y + 3`.
We then collect all atoms until we reach the symbol `'+`.
Similarly, for the remaining summands, we take everything after `'+`.
```scheme
(define (get-first op expr)
  (define (get-first-as-list expression)
    (if (or (null? expression)
            (eq? op (car expression)))
        '()
        (cons (car expression)
              (get-first-as-list (cdr expression)))))
  (unpack-singleton (get-first-as-list expr)))

(define (get-rest op expr)
  (define (get-rest-as-list expression)
    (cond ((null? expression) '())
          ((eq? (car expression) op) (cdr expression))
          (else (get-rest-as-list (cdr expression)))))
  (unpack-singleton (get-rest-as-list expr)))
```

We now get the constructors and selectors for sums and products for free:
```scheme
;;; Sums

(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? expr)
  (operation? '+ expr))

(define (addend sum)
  (get-first '+ sum))

(define (augend sum)
  (get-rest '+ sum))

;;; Products

(define (make-product x y)
  (cond ((or (=number? x 0) (=number? y 0)) 0)
        ((=number? x 1) y)
        ((=number? y 1) x)
        (else (combine '* * x y))))

(define (product? expr)
  (operation? '* expr))

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
