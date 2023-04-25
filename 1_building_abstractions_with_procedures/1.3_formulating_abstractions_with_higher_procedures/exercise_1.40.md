# Exercise 1.40

> Define a procedure `cubic` that can be used together with the `newtons-method` procedure in expressions of the form
> ```scheme
>   (newtons-method (cubic a b c) 1)
> ```
> to approximate zeros of the cubic $x^3 + ax^2 + bx + c$.



We can write such a procedure as follows:
```scheme
(define (cubic a b c)
  (lambda (x)
    (+ (* (cube x))
       (* a (square x))
       (* b x)
       c)))
```
We can then solve cubic equations with the following procedure:
```scheme
(define (solve-cubic a b c)
  (newtons-method (cubic a b c) 1.))
```
