# Exercise 2.81

> Louis Reasoner has noticed that `apply-generic` may try to coerce the arguments to each other’s type even if they already have the same type.
> Therefore, he reasons, we need to put procedures in the coercion table to “coerce” arguments of each type to their own type.
> For example, in addition to the `scheme-number->complex` coercion shown above, he would do:
> ```scheme
> (define (scheme-number->scheme-number n) n)
> (define (complex->complex z) z)
> (put-coercion 'scheme-number
>               'scheme-number
>               scheme-number->scheme-number)
> (put-coercion 'complex 'complex complex->complex)
> ```
>
> 1.  With Louis’s coercion procedures installed, what happens if `apply-generic` is called with two arguments of type `scheme-number` or two arguments of type `complex` for an operation that is not found in the table for those types?
>     For example, assume that we’ve defined a generic exponentiation operation:
>     ```scheme
>     (define (exp x y) (apply-generic 'exp x y))
>     ```
>     and have put a procedure for exponentiation in the Scheme-number package but not in any other package:
>     ```scheme
>     ;; following added to Scheme-number package
>     (put 'exp '(scheme-number scheme-number)
>          (lambda (x y) (tag (expt x y)))) ; using primitive expt
>     ```
>     What happens if we call `exp` with two complex numbers as arguments?
>
> 2.  Is Louis correct that something had to be done about coercion with arguments of the same type, or does `apply-generic` work correctly as is?
>
> 3.  Modify `apply-generic` so that it doesn’t try coercion if the two arguments have the same type.

---



### The problem

The current implementation of `apply-generic` will get caught in an endless loop if we try to access a non-registered operation for two arguments of the same type.

Say that we have two values `x` and `y` of the same type `t`, for which a coercion procedure from `t` to itself is registered (e.g., the identity procedure `(lambda (x) x)`).
Suppose further that for some symbol `'op` there is no procedure registered for `'op` and for the input signature `(t t)`.
That is, `(get 'op (list t t))` evaluates to `#f` instead of a procedure.

When we try to evaluate `(apply-generic 'op x y)`, the following will happen:

1.  First, `(get 'op (list t t)` will be evaluated, resulting in `#f`.
    This tells the interpreter that no procedure is available for `'op` with respect to inputs of type `t` and `t` respectively.

2.  To possibly circumvent this problem we consider the coercion procedures `t1->t2` and `t2->t1`, both determined via `(get-coercion t t)` and `(get-coercion t t)`.
    (Both `t1->t2` and `t2->t1` are the same procedure, but this won’t matter.)
    As assumed above, this coercion procedure exists.

3.  As `t1->t2` is an actual procedure, and not `#f`, we now try to evaluate `(apply-generic 'op (t1->t2 x) y)`.

However, `(t1->t2 x)` is again of type `t`.
So in terms of types we are back to step 1, and are now trapped in a loop.



### Solution

We have (at least) three possible solutions:

1.  Use `apply-generic` only if both arguments have different type, or when we can guarantee that the looked-up procedure exists.

2.  Disallow coercion from a type to itself by making it impossible to register such a procedure with `put-coercion`.

3.  Don’t let `apply-generic` coerce a type into itself.
    In our case of only two input arguments, this means that coercion must not be used if both arguments have the same type.

The first solution is highly impractical.

The second solution is probably the most elegant and robust one.
It stops you from shooting yourself in the foot by not letting you aim at your feet.

The third solution is also okay, and this is the solution the book is aiming for.
We can adjust `apply-generic` as follows:
```scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (not (eq? type1 type2))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2 (apply-generic op (t1->t2 a1) a2))
                            (t2->t1 (apply-generic op a1 (t2->t1 a2)))
                            (else (error "No method for these types"
                                         (list op type-tags)))))
                    (error "No method for these types"
                           (list op type-tags))))
              (error "No method for these types"
                     (list op type-tags)))))))
```
