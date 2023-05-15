# Exercise 2.79

> Define a generic equality predicate `equ?` that tests the equality of two numbers, and install it in the generic arithmetic package.
> This operation should work for ordinary numbers, rational numbers, and complex numbers.



We implement the predicate `equ?` via `apply-generic`:
```scheme
(define (equ? x y) (apply-generic 'equ? x y))
```

We compare native scheme numbers with the equality operator `=`.
We therefore add the following lines to `install-scheme-number-package`:
```scheme
(put 'equ?
     '(scheme-number scheme-number)
     (lambda (x y) (= x y)))
```
We note that this code commits the cardinal sin of comparing floating point numbers for strict equality.

Two rational numbers are compared via cross-multiplication.
We therefore add the following lines to `install-rational-package`:
```scheme
(put 'equ?
     '(rational rational)
     (lambda (x y) (= (* (numer x) (denom y))
                      (* (numer y) (denom x)))))
```

We compare two complex numbers by comparing their real and imaginary parts.
We add the following lines to `install-complex-package`:
```scheme
(put 'equ?
     '(complex complex)
     (lambda (x y) (and (= (real-part x) (real-part y))
                        (= (imag-part x) (imag-part y)))))
```
By comparing complex numbers in their rectangular form we avoid the non-uniqueness of the polar form.
