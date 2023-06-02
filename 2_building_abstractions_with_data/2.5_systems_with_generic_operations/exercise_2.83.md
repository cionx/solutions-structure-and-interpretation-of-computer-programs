# Exercise 2.83

> Suppose you are designing a generic arithmetic system for dealing with the tower of types shown in Figure 2.25:
> integer, rational, real, complex.
> For each type (except complex), design a procedure that raises objects of that type one level in the tower.
> Show how to install a generic raise operation that will work for each type (except complex).


### The type packages

We have so far implemented the number types `'scheme-number`, `'rational` and `'complex` (with `'complex` consisting of the two subtypes `'polar` and `'rectangular`).
For this exercise we introduce two additional types, `'integer` and `'real`.
We implement `'real` as `'scheme-number` plus an additional type-tag:
```scheme
(define (install-real-package)
  (define (tag x)
    (attach-tag 'real x))
  (put 'add '(real real) (lambda (x y) (tag (add x y))))
  (put 'sub '(real real) (lambda (x y) (tag (sub x y))))
  (put 'mul '(real real) (lambda (x y) (tag (mul x y))))
  (put 'div '(real real) (lambda (x y) (tag (div x y))))
  (put 'make 'real (lambda (x) (tag (make-scheme-number x))))
  'done)

(define (make-real x)
  ((get 'make 'real) x))
```
Note that in the definition of arithmetic operations for `'real`, the parameters `x` and `y` will already have their `'real` label torn off by `apply-generic`.
This means that `x` and `y` will be tagged as `'scheme-number`.
This allows us to use the procedures `add`, `sub`, etc.

We implement `'integer` similarly, but use Scheme’s `integer?` predicate to ensure that we are actually dealing with an integer.
```scheme
(define (install-integer-package)
  (define (tag x)
    (attach-tag 'integer x))
  (put 'add '(integer integer) (lambda (x y) (tag (add x y))))
  (put 'sub '(integer integer) (lambda (x y) (tag (sub x y))))
  (put 'mul '(integer integer) (lambda (x y) (tag (mul x y))))
  (put 'div '(integer integer) (lambda (x y) (tag (div x y))))
  (put 'make 'integer (lambda (n) (if (integer? n)
                                      (tag (make-scheme-number n))
                                      (error "Not an integer" n))))
  'done)

(define (make-integer n)
  ((get 'make 'integer) n))
```

We will also need to make a change to the rational package.
The procedures `denom` and `numer` are currently only available _inside_ the package, but not outside it.
This means that we have no way to access the numerical value of a rational number.
We can therefore not coerce a `'rational` number to a `'real` number.

We extend the rational package by making the procedures `denom` and `numer` publicly available:
```scheme
(define (install-rational-package)
  ⋮
  (put 'numer '(rational) numer)
  (put 'denom '(rational) denom)
  ⋮
  'done)

⋮

(install-rational-package)
(define (denom x) (apply-generic 'denom x))
(define (numer x) (apply-generic 'numer x))
```



### The coercion procedures

An `'integer` is just a `'scheme-number` with an additional `'integer` type-tag.
We therefore implement the coercion `integer->ratonal` coercion procedure in terms of an auxiliary coercion procedure `scheme-number->rational`.
```scheme
(define (scheme-number->rational n)
  (make-rational (contents n) 1))
(define (integer->rational n)
  (scheme-number->rational (contents n)))
```

The same goes for the coercion procedure from `'real` to `'complex`.
```scheme
(define (scheme-number->complex x)
  (make-complex-from-real-imag (contents x) 0))
(define (real->complex x)
  (scheme-number->complex (contents x)))
```

To convert a `'rational` number into a `'real` number we are using the public procedures `denom` and `numer` that we defined above.
```scheme
(define (rational->real x)
    (make-real (/ (numer x) (denom x))))
```

Finally, we register all three coercion procedures.
```scheme
(put-coercion 'integer 'rational integer->rational)
(put-coercion 'rational 'real rational->real)
(put-coercion 'real 'complex real->complex)
```



### The generic `raise` procedure

Intuitively speaking, we are going to implement the generic `raise` procedure via `apply-generic` and the above coercion procedures `integer->rational`, `rational->real` and `real->complex`.
```scheme
(put 'raise '(integer) integer->rational)
(put 'raise '(rational) rational->real)
(put 'raise '(real) real->complex)

(define (raise x)
  (apply-generic 'raise x))
```
However, this code doesn’t work as intended.
The problem is that `apply-generic` removes the type-tags of the arguments `x`, whereas coercion procedures require this label to be in place.

We have so far not found a good solution this problem.
For now, we are using the hack of re-attaching the type label before applying the coercion procedure:
```scheme
(put 'raise
     '(integer)
     (lambda (n) (integer->rational (attach-tag 'integer n))))
(put 'raise
     '(rational)
     (lambda (x) (rational->real (attach-tag 'rational x))))
(put 'raise
     '(real)
     (lambda (x) (real->complex (attach-tag 'real x))))
```
