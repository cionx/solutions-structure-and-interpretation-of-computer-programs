# Exercise 2.11

> In passing, Ben also cryptically comments:
> “By testing the signs of the endpoints of the intervals, it is possible to break `mul-interval` into nine cases, only one of which requires more than two multiplications.”
> Rewrite this procedure using Ben’s suggestion.

---

### The different cases

We distinguish for every interval $I$ between the following three cases:

- $I ≥ 0$, i.e., $x ≥ 0$ for every $x ∈ I$,

- $I ≤ 0$, i.e., $x ≤ 0$ for every $x ∈ I$,

- otherwise.

We respectively say that $I$ is _positive_, _negative_, or _mixed_.

In our code we assign to each interval its _sign_, which is either 1 (positive), -1 (negative) or 0 (mixed).
We then have nine cases to consider:

| sign of `x` | sign of `y` |
| ----------: | ----------: |
|  1          |  1          |
|  1          |  0          |
|  1          | -1          |
|  0          |  1          |
|  0          |  0          |
|  0          | -1          |
| -1          |  1          |
| -1          |  0          |
| -1          | -1          |

By the commutativity of multiplication it actually suffices to consider 6 of these 9 cases, namely those for which the sign of `x` is larger or equal to the sign of `y`:

| sign of `x` | sign of `y` |
| ----------: | ----------: |
|  1          |  1          |
|  1          |  0          |
|  1          | -1          |
|  0          |  0          |
|  0          | -1          |
| -1          | -1          |

In 5 of these cases we can directly determine the bounds of the product interval.
We still need `min` and `max` only in the cases that both `x` and `y` are mixed.

We make the following observations, where `x` is the interval $[l_x, u_x]$ and `y` is the interval $[l_y, u_y]$.

- If both $x ≥ 0$ and $y ≥ 0$ then simply $x ⋅ y = [l_x l_y, u_x u_y]$.

- If $x ≥ 0$ and $y$ is mixed, then $x ⋅ y$ is the union of the intervals $λ y$ with $λ ∈ x$.
  If $0 ≤ λ ≤ μ$ then $λ y ⊆ μ y$ because $y$ is an interval around 0.
  Consequently, $x ⋅ y$ equals $(\max x) y = u_x y$.
  As $u_x$ is non-negative, we further find that $u_x y$ equals $[u_x l_y, u_x u_y]$.
  Altogether, $x ⋅ y = u_x y = [u_x l_y, u_x u_y]$.

The other three pre-determined cases can now be derived from the above two:

- Suppose that $x$ is positive and $y$ is negative.
  Then $-y$ is positive with $-y = [- u_y, - l_y]$, and therefore
  $$
    x ⋅ y
    = - (x ⋅ (-y))
    = - ( \underbrace{[l_x, u_x]}_{≥ 0} ⋅ \underbrace{[- u_y, - l_y]}_{≥ 0} )
    = - [- l_x u_y, - u_x l_y]
    = [u_x l_y, l_x u_y] \,.
  $$

- Suppose that $x$ is mixed and $y$ is negative.
  Then $-y$ and positive with $-y = [- u_y, - l_y]$.
  It follows that
  $$
    \begin{aligned}
      x ⋅ y
      &=
      - (x ⋅ (-y)) \\
      &=
      - ((-y) ⋅ x) \\
      &=
      - (\underbrace{[- u_y, - l_y]}_{≥ 0} ⋅ \underbrace{[l_x, u_x]}_{\text{mixed}}) \\
      &=
      - [- l_y l_x, - l_y u_x] \\
      &=
      [l_y u_x, l_y l_x] \\
      &=
      [u_x l_y, l_x l_y] \,.
    \end{aligned}
  $$

- Suppose that both $x$ and $y$ are positive.
  Then both $-x = [- u_x, - l_x]$ and $-y = [- u_y, - l_y]$ are positive.
  It follows that
  $$
    x ⋅ y
    =
    (-x) ⋅ (-y)
    =
    \underbrace{[- u_x, - l_x]}_{≥ 0} ⋅ \underbrace{[- u_y, - l_y]}_{≥ 0}
    =
    [u_x u_y, l_x l_y] \,.
  $$

### The resulting code

We arrive overall at the following code:
```scheme
(define (mul-interval x y)
  (define (sign-interval z)
    (cond ((<= 0 (lower-bound z)) 1)
          ((<= (upper-bound z) 0) -1)
          (else 0)))
  (let ((x-sign (sign-interval x))
        (y-sign (sign-interval y)))
    (cond
      ;; By commutativity of multiplication we may assume that
      ;;    x-sign >= y-sign.
      ;; Otherwise we swap the factors.
      ((< x-sign y-sign)
       (mul-interval y x))
      ;; Both intervals are positive.
      ((and (= x-sign 1) (= y-sign 1))
       (make-interval (* (lower-bound x) (lower-bound y))
                      (* (upper-bound x) (upper-bound y))))
       ;; x is positive, y is mixed
      ((and (= x-sign 1) (= y-sign 0))
       (make-interval (* (upper-bound x) (lower-bound y))
                      (* (upper-bound x) (upper-bound y))))
      ;; x is positive, y is negative
      ((and (= x-sign 1) (= y-sign -1))
       (make-interval (* (upper-bound x) (lower-bound y))
                      (* (lower-bound x) (upper-bound y))))
      ;; x is mixed, y is mixed
      ((and (= x-sign 0) (= y-sign 0))
       (let ((p1 (* (lower-bound x) (lower-bound y)))
             (p2 (* (lower-bound x) (upper-bound y)))
             (p3 (* (upper-bound x) (lower-bound y)))
             (p4 (* (upper-bound x) (upper-bound y))))
         (make-interval (min p1 p2 p3 p4)
                        (max p1 p2 p3 p4))))
      ;; x is mixed, y is negative
      ((and (= x-sign 0) (= y-sign -1))
       (make-interval (* (upper-bound x) (lower-bound y))
                      (* (lower-bound x) (lower-bound y))))
      ;; x is negative, y is negative
      ((and (= x-sign -1) (= y-sign -1))
       (make-interval (* (upper-bound x) (upper-bound y))
                      (* (lower-bound x) (lower-bound y))))
      ;; We should never reach the following.
      (else (error "Unknown sign combinatin in mult-interval"
                   x-sign
                   y-sign)))))
```

### Testing

We can test the above code with the following auxiliary code:
```scheme
(define (mul-interval-old x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (eq-interval? x y)
  (and (= (lower-bound x) (lower-bound y))
       (= (upper-bound x) (upper-bound y))))

(define (old a b c d)
  (let ((x (make-interval a b))
        (y (make-interval c d)))
    (mul-interval-old x y)))

(define (new a b c d)
  (let ((x (make-interval a b))
        (y (make-interval c d)))
    (mul-interval x y)))

(define (same-mul? a b c d)
  (eq-interval? (new a b c d) (old a b c d)))

;; All tests should print #t.
(newline) (display (same-mul?  2  5  1  3)) ; positive, positive
(newline) (display (same-mul?  2  5 -1  3)) ; positive, mixed
(newline) (display (same-mul?  2  5 -3 -1)) ; positive, negative
(newline) (display (same-mul? -2  5  1  3)) ; mixed, positive
(newline) (display (same-mul? -2  5 -1  3)) ; mixed, mixed
(newline) (display (same-mul? -2  5 -3 -1)) ; mixed, negative
(newline) (display (same-mul? -5 -2  1  3)) ; negative, positive
(newline) (display (same-mul? -5 -2 -1  3)) ; negative, mixed
(newline) (display (same-mul? -5 -2 -3 -1)) ; negative, negative
```
(We choose the intervals in our tests so that no two products of endpoints are equal.
This ought to prevent coincidental passing of tests.)
All tests display `#t`:
```text
$ mit-scheme --load exercise_2.11_test.scm
MIT/GNU Scheme running under GNU/Linux
Type `^C' (control-C) followed by `H' to obtain information about interrupts.

Copyright (C) 2022 Massachusetts Institute of Technology
This is free software; see the source for copying conditions. There is NO warranty; not
even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Image saved on Friday January 6, 2023 at 10:11:41 PM
  Release 12.1 || SF || LIAR/x86-64
;Loading "exercise_2.11_test.scm"...
;  Loading "exercise_2.11.scm"...
;    Loading "../../sicplib.scm"... done
;  ... done

#t
#t
#t
#t
#t
#t
#t
#t
#t
;... done
```
