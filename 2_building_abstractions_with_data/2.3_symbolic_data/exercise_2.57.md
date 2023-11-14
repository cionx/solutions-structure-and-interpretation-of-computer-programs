# Exercise 2.57

> Extend the differentiation program to handle sums and products of arbitrary numbers of (two or more) terms.
> Then the last example above could be expressed as
> ```scheme
>   (deriv '(* x y (+ x 3)) 'x)
> ```
> Try to do this by changing only the representation for sums and products, without changing the `deriv` procedure at all.
> For example, the `addend` of a sum would be the first term, and the `augend` would be the sum of the rest of the terms.

---

### The general representation

We encode sums as lists of the form `('+ ⟨a1⟩ … ⟨an⟩)` and similarly products as lists of the form `('* ⟨a1⟩ … ⟨an⟩)`.
We call such lists _combinations_, and `⟨a1⟩ … ⟨an⟩` the _terms_ of the combination.
We refer to `'+` and `'*` as _symbolic operations_.
An _expression_ is either a combination, a variable, or a number.

The procedures `addend` and `multiplier` will return a combination’s first term, while `augend` and `multiplicand` will remove this first term.
(If there is only one term remaining, then there will also be some simplification, as we will discuss in a moment.)

### Recognizing a combination of terms

To recognize a combination, and to later on define `sum?` and `product?`, we use a shared abstraction:
```scheme
(define (operation? symbolic-op expr)
  (and (pair? expr) (eq? (car expr) symbolic-op)))

(define (terms expr)
  (cdr expr))
```

### Combining two expressions

To combine two expressions `x` and `y`, say via addition, we have to consider the following cases in the given order:

1. The special cases when `x` is zero or `y` is zero.

2. The special case that both `x` and `y` are numbers.

3. The case that both `x` and `y` are themselves sum-combinations.
   In this case we need to combine their lists of terms into a single list.

4. The case that either `x` or `y` is a sum-combination, but the other one is not.
   In this case we need to append the not-sum expression to the list of terms of the sum-combination.

5. Neither `x` nor `y` is a sum-combination.
   In this case we simply combine them via `(list '+ x y)`.

An analogous discussion holds true for multiplication instead of addition.
We can combine all but the first case into a shared abstraction for combining two expressions via an operation:
```scheme
(define (combine symbolic-op number-op x y)
  (cond ((and (number? x) (number? y)) (number-op x y))
        ((and (operation? symbolic-op x)
              (operation? symbolic-op y))
         (cons symbolic-op (append (terms x) (terms y))))
        ((operation? symbolic-op x)
         (cons symbolic-op (append (terms x) (list y))))
        ((operation? symbolic-op y)
         (cons symbolic-op (cons x (terms y))))
        (else (list symbolic-op x y))))
```

### Extracting terms

The procedures `addend` and `multiplier` will extract the first term of a combination, and thus have a shared abstraction:
```scheme
(define (get-first combination)
  (cadr combination))
```

The procedures `augend` and `multiplicand` will extract all-but-first terms of a combination, which means that we remove the first term of the combination.
We need to be careful with this removal:
Singleton-combinations like `('+ expr)` or `('* expr)` should be further simplified to just `expr`.
Removing the first term of combination could result in such a singleton-combination, which then needs simplification.
(We want to point out that the above procedure `combine` doesn’t produce singleton-combinations, so we didn’t need to worry about this problem until now.)

We introduce an auxiliary procedure `format-operation` that combines a list of terms with respect to a given symbolic operation, and executes the above simplification if possible.
```scheme
(define (singleton? x)
  (and (pair? x) (null? (cdr x))))

(define (format-operation symbolic-op terms)
  (if (singleton? terms)
      (car terms)
      (cons symbolic-op terms)))
```

We can now extract all but the first term of a combination while simplifying the result if possible:
```scheme
(define (get-rest combination)
  (format-operation (car combination) (cddr combination)))
```

### Sums and products

We can now implement sums and products in terms of the above shared abstractions:
```scheme
(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        (else (combine '+ + x y))))

(define (sum? expr)
  (operation? '+ expr))

(define (addend sum)
  (get-first sum))

(define (augend sum)
  (get-rest sum))
```

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
