# Exercise 2.85

> This section mentioned a method for “simplifying” a data object by lowering it in the tower of types as far as possible.
> Design a procedure `drop` that accomplishes this for the tower described in Exercise 2.83. The key is to decide, in some general way, whether an object can be lowered.
> For example, the complex number $1.5 + 0i$ can be lowered as far as `real`, the complex number $1 + 0i$ can be lowered as far as `integer`, and the complex number $2 + 3i$ cannot be lowered at all.
> Here is a plan for determining whether an object can be lowered:
> Begin by defining a generic operation `project` that “pushes” an object down in the tower.
> For example, projecting a complex number would involve throwing away the imaginary part.
> Then a number can be dropped if, when we `project` it and `raise` the result back to the type we started with, we end up with something equal to what we started with.
> Show how to implement this idea in detail, by writing a `drop` procedure that drops an object as far as possible.
> You will need to design the various projection operations⁵³ and install `project` as a generic operation in the system.
> You will also need to make use of a generic equality predicate, such as described in Exercise 2.79.
> Finally, use `drop` to rewrite `apply-generic` from Exercise 2.84 so that it “simplifies” its answers.
>
> ⁵³ A real number can be projected to an integer using the `round` primitive, which returns the closest integer to its argument.

---

For this exercise we will consider only the smaller tower of types
```text
integer → real → complex
```
because there is no suitable projection procedure from `real` to `rational`.

We implement integers and reals as in Exercise 2.83.
```scheme
;;; The following implementation of integers and real numbers is taken from
;;; Exercise 2.83.

;;; Integers

(define (install-integer-package)
  (define (tag x) (attach-tag 'integer x))
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

;;; Reals

(define (install-real-package)
  (define (tag x) (attach-tag 'real x))
  (put 'add '(real real) (lambda (x y) (tag (add x y))))
  (put 'sub '(real real) (lambda (x y) (tag (sub x y))))
  (put 'mul '(real real) (lambda (x y) (tag (mul x y))))
  (put 'div '(real real) (lambda (x y) (tag (div x y))))
  (put 'make 'real (lambda (x) (tag (make-scheme-number x))))
  'done)

(define (make-real x)
  ((get 'make 'real) x))
```

We implement the generic procedure `equ?` using `apply-generic`, similarly to Exercise 2.79.
```scheme
;;; Equality procedures

(define (equ? x y) (apply-generic 'equ? x y))

;; Equality of scheme-numbers, taken from Exercise 2.79
(put 'equ?
     '(scheme-number scheme-number)
     (lambda (x y) (= x y))) ; x and y are primitive numbers

;; Equality of integers
(put 'equ?
     '(integer integer)
     (lambda (x y) (equ? x y))) ; x and y are 'scheme-number

;; Equality of reals
(put 'equ?
     '(real real)
     (lambda (x y) (equ? x y))) ; x and y are 'scheme-number

;; Equality of complex numbers, taken from Exercise 2.79
(put 'equ?
     '(complex complex)
     (lambda (x y) (and (= (real-part x) (real-part y))
                        (= (imag-part x) (imag-part y)))))
```

We will eventually modify the procedure `apply-generic` so that it’s output is simplified.
But the output of the procedures `raise` and `project` is not supposed to be simplified.
This means that we cannot implement these two procedures in terms of `apply-generic`.
(We would also run into a dependency cycle.)

We therefore define `raise` via explicit dispatch.
```scheme
;;; Raising procedure, similar to Exercise 2.83

(define (integer->scheme-number n)
  (contents n))

(define (real->scheme-number x)
  (contents x))

(define (scheme-number->primitive x)
  (contents x))

(define (integer->primitive n)
  (scheme-number->primitive (integer->scheme-number n)))

(define (real->primitive x)
  (scheme-number->primitive (real->scheme-number x)))

(define (raise x)
  (let ((type (type-tag x)))
    (cond ((eq? type 'integer)
           (make-real (integer->primitive x)))
          ((eq? type 'real)
           (make-complex-from-real-imag (real->primitive x) 0))
          (else (error "Cannot raise" x)))))
```

The projection procedure is similarly defined via explicit dispatch.
```scheme
;;; Projection procedure

(define (project x)
  (let ((type (type-tag x)))
    (cond ((eq? type 'complex)
           (make-real (real-part x)))
          ((eq? type 'real)
           (make-integer (round (real->primitive x))))
          (else (error "Cannot project down" x)))))
```

A value can only be possibly simplified if it is a tagged-datum of type `'complex` or `'real`.
Otherwise, `drop` will simply leave its input value unchanged.
```scheme
;;; Drop procedure

(define (tagged-datum? datum)
  (and (pair? datum)
       (symbol? (car datum))))

(define (can-project? x)
  (and (tagged-datum? x)
       (let ((type (type-tag x)))
         (or (eq? type 'complex)
             (eq? type 'real)))))

(define (can-simplify? x)
  (and (can-project? x)
       (equ? x (raise (project x)))))

(define (drop x)
  (if (can-simplify? x)
      (drop (project x))
      x))
```

We can now re-define `apply-generic` by adding `drop`:
```scheme
;;; Re-definition of apply-generic

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (drop (apply proc (map contents args))) ; add drop support
          (error "No method for these types: APPLY-GENERIC"
                 (list op type-tags))))))
```

We can test our code with the previous example:
```text
1 ]=> (define y1 (make-complex-from-real-imag 2 3))

;Value: y1

1 ]=> y1

;Value: (complex rectangular 2 . 3)


1 ]=> (define y2 (make-complex-from-real-imag 4 -3))

;Value: y2

1 ]=> y2

;Value: (complex rectangular 4 . -3)


1 ]=> (add y1 y2)

;Value: (integer scheme-number . 6)
```


### Note

Our system is not very robust, and small changes can easily lead to dependency cycles.
We also used a version of `apply-generic` that does not support any form of coercion to keep our code simple.
