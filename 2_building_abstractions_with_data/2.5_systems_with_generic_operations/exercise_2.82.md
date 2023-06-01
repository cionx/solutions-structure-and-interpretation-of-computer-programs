# Exercise 2.82

> Show how to generalize `apply-generic` to handle coercion in the general case of multiple arguments.
> One strategy is to attempt to coerce all the arguments to the type of the first argument, then to the type of the second argument, and so on.
> Give an example of a situation where this strategy (and likewise the two-argument version given above) is not sufficiently general.
> (Hint: Consider the case where there are some suitable mixed-type operations present in the table that will not be tried.)



### The code

We use an auxiliary procedure `get-common-coercions` that plays a similar role as `got-coercion`, but which considers multiple input types at once:
Instead of a single input type and target type, the input is a _list_ of types and a target type.
The procedure returns a list of coercion procedures if each type in the list can be coerced to the given target type.
The _i_-th entry of the output list is the coercion procedure from the _i_-th input type to the target type.
If it is not possible to coerce all input types to the target type, then `#f` is returned.
```scheme
(define (get-common-coercions arg-types target-type)
    (if (null? arg-types)
        '()
        (let ((head (car arg-types))
              (tail (cdr arg-types)))
          (let ((head->target-type
                  (if (eq? head target-type)
                      identity
                      (get-coercion head target-type)))
                (tail->target-type
                  (get-common-coercions tail target-type)))
            (if (and head->target-type tail->target-type)
                (cons head->target-type tail->target-type)
                #f)))))
```
To apply a list of coercion procedures to a list of values, with the _i_-th coercion applied to the _i_-th value, we use another auxiliary procedure:
```scheme
;; Both lists need to have the same length.
(define (zip-apply function-list value-list)
  (if (null? function-list)
      '()
      (cons ((car function-list) (car value-list))
            (zip-apply (cdr function-list) (cdr value-list)))))
```
Given an operation `op` and a list of arguments `args`, we will use an auxiliary `iter` procedure, which takes as input a list of possible target types.
The `iter` procedure goes through the list of possible target types.
For each target type, it tries to coerce all `args` to this type, and then looks up a procedure for the given operation `op` and the coerced types.
```scheme
(define (iter target-types)
    (if (null? target-types)
        (error "No method for these types")
        (let ((target-type (car target-types))
              (other-types (cdr target-types))
              (arg-types (map type-tag args)))
          (let ((coercions (get-common-coercions arg-types target-type)))
            (if coercions
                (let ((coerced-args (zip-apply coercions args)))
                  (let ((coerced-types (map type-tag coerced-args)))
                    (let ((proc (get op coerced-types)))
                      (if proc
                          (apply proc (map contents coerced-args))
                          (iter other-types)))))
                (iter other-types))))))
```

Our code looks altogether as follows:
```scheme
(define (apply-generic op . args)
  (define (get-common-coercions arg-types target-type)
    (if (null? arg-types)
        '()
        (let ((head (car arg-types))
              (tail (cdr arg-types)))
          (let ((head->target-type
                  (if (eq? head target-type)
                      identity
                      (get-coercion head target-type)))
                (tail->target-type
                  (get-common-coercions tail target-type)))
            (if (and head->target-type tail->target-type)
                (cons head->target-type tail->target-type)
                #f)))))
  (define (iter target-types)
    (if (null? target-types)
        (error "No method for these types")
        (let ((target-type (car target-types))
              (other-types (cdr target-types))
              (arg-types (map type-tag args)))
          (let ((coercions (get-common-coercions arg-types target-type)))
            (if coercions
                (let ((coerced-args (zip-apply coercions args)))
                  (let ((coerced-types (map type-tag coerced-args)))
                    (let ((proc (get op coerced-types)))
                      (if proc
                          (apply proc (map contents coerced-args))
                          (iter other-types)))))
                (iter other-types))))))
  (iter (map type-tag args)))

;; Both lists need to have the same length.
(define (zip-apply function-list value-list)
  (if (null? function-list)
      '()
      (cons ((car function-list) (car value-list))
            (zip-apply (cdr function-list) (cdr value-list)))))
```



### The problem

Both versions have the problem that they only consider coercion to the type of one of the arguments.
But it may happen that we need to coerce to some additional type, which none of the arguments has.

Our generalized version of `apply-generic` also skips some possible coercions.
Say for example that we have three arguments, `x`, `y` and `z`, of types `t1`, `t2`, `t3` respectively.
Suppose that `t1` can be coerced to `t2`, and that both `t1` and `t3` can be coerced to `t3`.
If an operation `op` is defined for one of the signatures `'(t1, t3, t3)`, `'(t2 t2 t3)` or `'(t2, t3, t3)` or `'(t3, t2, t3)`, then our generalized version of `apply-generic` won’t be able to evaluate `(apply-generic op x y z)`, even though this would be possible by a suitable choice of coercions.
It will only check the signatures `(t1, t2, t3)` and `(t3, t3, t3)`.
