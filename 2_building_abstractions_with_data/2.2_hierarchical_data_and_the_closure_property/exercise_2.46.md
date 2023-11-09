# Exercise 2.46

> A two-dimensional vector $v$ running from the origin to a point can be represented as a pair consisting of an $x$-coordinate and a $y$-coordinate.
> Implement a data abstraction for vectors by giving a constructor `make-vect` and corresponding selectors `xcor-vect` and `ycor-vect`.
> In terms of your selectors and constructor, implement procedures `add-vect`, `sub-vect`, and `scale-vect` that perform the operations vector addition, vector subtraction, and multiplying a vector by a scalar:
> $$
> \begin{aligned}
>   (x_1, y_1) + (x_2, y_2) &= (x_1 + x_2, y_1 + y_2) \,, \\
>   (x_1, y_1) - (x_2, y_2) &= (x_1 - x_2, y_1 - y_2) \,, \\
>   s ⋅ (x, y)              &= (s x, s y) \,.
> \end{aligned}
> $$

---

The constructor and selectors can be written as follows:
```scheme
(define (make-vect x y)
  (list x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cadr v))
```

The algebraic operations of vector addition, vector subtraction and scalar multiplication can then be implemented as follows:
```scheme
(define (add-vect v w)
  (make-vect (+ (xcor-vect v)
                (xcor-vect w))
             (+ (ycor-vect v)
                (ycor-vect w))))

(define (sub-vect v w)
  (make-vect (- (xcor-vect v)
                (xcor-vect w))
             (- (ycor-vect v)
                (ycor-vect w))))

(define (scale-vect scalar v)
  (make-vect (* scalar (xcor-vect v))
             (* scalar (ycor-vect v))))
```
