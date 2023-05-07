# Exercise 2.76

> As a large system with generic operations evolves, new types of data objects or new operations may be needed.
> For each of the three strategies—generic operations with explicit dispatch, data-directed style, and message-passing-style—describe the changes that must be made to a system in order to add new types or new operations.
> Which organization would be most appropriate for a system in which new types must often be added?
> Which would be most appropriate for a system in which new operations must often be added?



We assume that the given three strategies are as follows:

- By “explicit dispatch” we refer to the strategy used in subsection 2.4.2, which resulted in the following code:
  ```scheme
  (define (real-part z)
    (cond ((rectangular? z)
           (real-part-rectangular (contents z)))
          ((polar? z)
           (real-part-polar (contents z)))
          (else (error "Unknown type: REAL-PART" z))))

  (define (imag-part z)
    (cond ((rectangular? z)
           (imag-part-rectangular (contents z)))
          ((polar? z)
           (imag-part-polar (contents z)))
          (else (error "Unknown type: IMAG-PART" z))))

  (define (magnitude z)
    (cond ((rectangular? z)
           (magnitude-rectangular (contents z)))
          ((polar? z)
           (magnitude-polar (contents z)))
          (else (error "Unknown type: MAGNITUDE" z))))

  (define (angle z)
    (cond ((rectangular? z)
           (angle-rectangular (contents z)))
          ((polar? z)
           (angle-polar (contents z)))
          (else (error "Unknown type: ANGLE" z))))
  ```

- By “data-directed” we refer to the first of the two strategies presented in Subsection 2.4.3, which installed the procedures in a table:
  ```scheme
  (define (install-rectangular-package)
    ;; internal procedures
    (define (real-part z) (car z))
    (define (imag-part z) (cdr z))
    (define (make-from-real-imag x y) (cons x y))
    (define (magnitude z)
      (sqrt (+ (square (real-part z))
               (square (imag-part z)))))
    (define (angle z)
      (atan (imag-part z) (real-part z)))
    (define (make-from-mag-ang r a)
      (cons (* r (cos a)) (* r (sin a))))
    ;; interface to the rest of the system
    (define (tag x) (attach-tag 'rectangular x))
    (put 'real-part '(rectangular) real-part)
    (put 'imag-part '(rectangular) imag-part)
    (put 'magnitude '(rectangular) magnitude)
    (put 'angle '(rectangular) angle)
    (put 'make-from-real-imag 'rectangular
         (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'rectangular
         (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)

  (define (install-polar-package)
    ;; internal procedures
    (define (magnitude z) (car z))
    (define (angle z) (cdr z))
    (define (make-from-mag-ang r a) (cons r a))
    (define (real-part z) (* (magnitude z) (cos (angle z))))
    (define (imag-part z) (* (magnitude z) (sin (angle z))))
    (define (make-from-real-imag x y)
      (cons (sqrt (+ (square x) (square y)))
            (atan y x)))
    (define (tag x) (attach-tag 'polar x))
    (put 'real-part '(polar) real-part)
    (put 'imag-part '(polar) imag-part)
    (put 'magnitude '(polar) magnitude)
    (put 'angle '(polar) angle)
    (put 'make-from-real-imag 'polar
         (lambda (x y) (tag (make-from-real-imag x y))))
    (put 'make-from-mag-ang 'polar
         (lambda (r a) (tag (make-from-mag-ang r a))))
    'done)
  ```
- By “message-passing” we refer to the second of the two strategies presented in Subsection 2.4.3, in which an object is represented by its dispatches:
  ```scheme
  (define (make-from-real-imag x y)
    (define (dispatch op)
      (cond ((eq? op 'real-part) x)
            ((eq? op 'imag-part) y)
            ((eq? op 'magnitude)
             (sqrt (+ (square x) (square y))))
            ((eq? op 'angle) (atan y x))
            (else
             (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
    dispatch)
  ```



### Explicit dispatch & message-passing

For explicit dispatch we need to add a new procedure for each new operation, but do not need to modify the already existing procedures.
But when we add a new type of input, then we need to modify all existing procedures.

The message-passing style similarly requires us to write a new procedure for each new operation, while adding a new type requires us to modify all already existing procedures.

For an organization that is often adding new operations but only rarely new types, both explicit dispatch and message-passing may be appropriate.
For an organization that is rarely adding new operations but frequently new types, neither explicit dispatch nor message-passing seems to be a good choice.



### Data-directed

For the data-directed approach, we need to install new procedures in the table anytime we add new operations or new types.

We have previously organized these installations in one package per type.
So if we were to add a new type, then we would need to add a new package for that type.
The packages for the previous types would remain unaffected.

When adding a new operation, we have two possible choices:

1.  Modify each existing type package to add support for the new operation.

2.  Introduce packages not only for types but also for operations:
    such a package would then define the new operation for all existing types.

The first approach forces us to modify each of the already existing packages.

The second approach allows us to keep these packages untouched, but forces us to introduce packages not only for types for also for operations.
This will probably lead to a mess, and can even lead to conflicting definitions, as both a type package and an operation package may try to install the same table entry.

For an organization that is often adding new types, but rarely new operations, the data-directed approach may be suitable.

For an organization that is very rarely adding new types, but often new operations, the data-directed approach may also be suitable:
in this case it may be feasible to simply add a new package for each new operation and keep the packages for the types mostly untouched.
This should reduce the problem of possible conflicts.
However, for such an organization it may be better to just use explicit dispatch or message-passing instead.

If we don’t allow packages for operations, but only for types, then such an organization (that has rarely new types but often new operations) probably shouldn’t use the data-directed approach.
