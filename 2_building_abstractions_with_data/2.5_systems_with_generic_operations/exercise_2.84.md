# Exercise 2.84

> Using the `raise` operation of Exercise 2.83, modify the `apply-generic` procedure so that it coerces its arguments to have the same type by the method of successive raising, as discussed in this section.
> You will need to devise a way to test which of two types is higher in the tower.
> Do this in a manner that is “compatible” with the rest of the system and will not lead to problems in adding new levels to the tower.

---

We assign to each of the types `'integer`, `'rational`, `'real` and `'complex` a “level”, which is the height of this type in the tower of types.
We use a procedure `get-level` to determine the level of a number.
For arguments that are not of these four types, the procedure returns `#f` instead.
```scheme
(define (get-level x)
  (let ((type (type-tag x)))
    (cond ((eq? type 'integer) 0)
          ((eq? type 'rational) 1)
          ((eq? type 'real) 2)
          ((eq? type 'complex) 3)
          (else #f))))
```
We could have also implemented `get-type` as a generic procedure via `apply-generic`.
Our approach gives a better overview over the different type levels.

To (repeatedly) raise a number to a specified target level we use a procedure `raise-to-level`.
If the specified target level is `#f`, then nothing happens.
```scheme
(define (raise-to-level x target-level)
  (define (iter x)
    (if (< (get-level x) target-level)
        (iter (raise x))
        x))
  (if target-level (iter x) x))
```
We will need to be able to determine the maximal level in a list of levels.
If the list is empty, or if one of the levels is `#f`, then the result is `#f`.
```scheme
(define (level-max . level-list)
  (define (binary-level-max level1 level2)
    (if (and level1 level2)
        (max level1 level2)
        #f))
  (define (iter acc levels)
    (if (null? levels)
        acc
        (iter (binary-level-max acc (car levels))
              (cdr levels))))
  (if (null? level-list)
      #f
      (iter (car level-list) (cdr level-list))))
```

Finally, for the new version of `apply-generic`, we proceed as follows:

1. We first try to find a procedure for the initial types of the arguments.

Suppose that no procedure can be found.

2. We determine the type level of each argument using `get-level`.

3. We then use `level-max` to determine the highest occurring level.

4. Finally, we raise each argument to this maximal level using `raise-to-level`.

5. We try to find a procedure for the new types.

6. If we still have no success, then we raise an error.

Note that if one of the arguments is not of the number types `'integer`, `'rational`, `'real` or `'complex`, then `get-level` will return `#f` for this argument.
This will then make `level-max` also return `#f`, which will make `raise-to-level` do nothing.
Step 5 will then do the exact same thing as type 1.
```scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc-1 (get op type-tags)))
      (if proc-1
          (apply proc-1 (map contents args))
          (if (null? args)
              (error "No method for these types"
                     (list op type-tags))
              (let ((target-level (apply level-max (map get-level args))))
                (let ((coerced-args
                       (map (lambda (x) (raise-to-level x target-level))
                            args)))
                  (let ((coerced-type-tags (map type-tag coerced-args)))
                    (let ((proc-2 (get op coerced-type-tags)))
                      (if proc-2
                          (apply proc-2 (map contents coerced-args))
                          (error "No method for these types"
                                 (list op type-tags))))))))))))
```
