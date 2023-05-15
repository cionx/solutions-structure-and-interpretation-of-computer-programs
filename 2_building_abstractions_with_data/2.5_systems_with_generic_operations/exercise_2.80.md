# Exercise 2.80

> Define a generic predicate `=zero?` that tests if its argument is zero, and install it in the generic arithmetic package.
> This operation should work for ordinary numbers, rational numbers, and complex numbers.



We define the generic predicate `=zero?` in terms of `apply-generic`:
```scheme
(define (=zero? x) (apply-generic 'zero? x))
```

We add the following code to the `scheme-number` package:
```scheme
(put 'zero?
     '(scheme-number)
     (lambda (x) (= x 0)))
```
We add the following code to the `rational` package:
```scheme
(put 'zero?
     '(rational)
     (lambda (x) (= (numer x) 0)))
```

For complex numbers we decided to implement different procedures for `'rectangular` and `'polar`.
We add the following code to the `rectangular` package:
```scheme
(put 'zero? '(rectangular)
     (lambda (z) (and (= (real-part z) 0)
                      (= (imag-part z) 0))))
```
We then add the following code to the `polar` package:
```scheme
(put 'zero? '(polar)
     (lambda (z) (= (magnitude z) 0)))
```
For the general `complex` package, we then use the fact that `=zero?` can already deal with both `'rectangular` and `'polar` numbers.
We add the following code to the `complex` package:
```scheme
(put 'zero?
     '(complex)
     (lambda (x) (=zero? x)))
```
