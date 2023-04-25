# Exercise 1.5

> Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation.
> He defines the following two procedures:
> ```scheme
> (define (p) (p))
>
> (define (test x y)
>   (if (= x 0) 0 y))
> ```
> Then he evaluates the expression
> ```scheme
> (test 0 (p))
> ```
> What behavior will Ben observe with an interpreter that uses applicative-order evaluation?
> What behavior will he observe with an interpreter that uses normal-order evaluation?
> Explain your answer.
> (Assume that the evaluation rule for the special form `if` is the same whether the interpreter is using normal or applicative order:
> The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)



### Applicative-order evaluation

The expression `(test 0 (p))` is a combination.
To evaluate it with applicative-order evaluation, we first need to evaluate the three subexpressions `test`, `0` and `(p)`.
The expression `test` evaluates to the procedure of the same name, and `0` to the integer of the same name, so we are left with evaluating `(p)`.
As `(p)` is defined as `(p)`, this evaluation of `(p)` requires us to… evaluate `(p)`!
The interpreter will now be stuck in a loop, forever trying to evaluate `(p)` (the second term in `(define (p) (p))` by evaluating `(p)` (the third term in `(define (p) (p)`).



### Normal-order evaluation
To evaluate the expression
```scheme
  (test 0 (p))
```
with normal-order evaluation, we take the definition of `test` and replace the variables `x` and `y` by the expressions `0` and `(p)` respectively.
We arrive at the following expression:
```scheme
(if (= 0 0) 0 (p))
```
As explained in the exercise, the special form `if` is evaluated by first evaluating the predicate expression, and then focusing on the respective subexpression.
This gives us the following expressions:
```scheme
(if (= 0 0) 0 (p))

(if #t 0 (p))

0
```
We have arrived at a primitive value (namely the integer `0`), which is the result of the overall evaluation.
