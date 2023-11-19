# Exercise 2.78

> The internal procedures in the `scheme-number` package are essentially nothing more than calls to the primitive procedures `+`, `-`, etc.
> It was not possible to use the primitives of the language directly because our type-tag system requires that each data object have a type attached to it.
> In fact, however, all Lisp implementations do have a type system, which they use internally.
> Primitive predicates such as `symbol?` and `number?` determine whether data objects have particular types.
> Modify the definitions of `type-tag`, `contents`, and `attach-tag` from Section 2.4.2 so that our generic system takes advantage of Scheme’s internal type system.
> That is to say, the system should work as before except that ordinary numbers should be represented simply as Scheme numbers rather than as pairs whose `car` is the symbol `scheme-number`.

---

First, we make sure that the procedure `attach-tag` does not add the label `'scheme-number` in front of any number:
```scheme
(define (attach-tag type-tag contents)
  (if (and (eq? type-tag 'scheme-number)
           (number? contents))
      contents
      (cons type-tag contents)))
```
Note that we could still tag other kinds of data with `'scheme-number` (which would probably lead to problems down to road), or tag numbers with tags different from `'scheme-number` (since a number could serve as a representative for a non-number data type).

Next, we need to ensure that the procedure `contents` doesn’t try to remove the non-existing label in front of numbers:
```scheme
(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum: CONTENTS" datum))))
```

Finally, the procedure `type-tag` still needs to return the tag `'scheme-number`, even if the tag is not actually there:
this tag is needed so that `apply-generic` can look up the correct procedures.
```scheme
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum: TYPE-TAG" datum))))
```
