# Exercise 2.2

> Consider the problem of representing line segments in a plane.
> Each segment is represented as a pair of points:
> a starting point and an ending point.
> Define a constructor `make-segment` and selectors `start-segment` and `end-segment` that define the representation of segments in terms of points.
> Furthermore, a point can be represented as a pair of numbers:
> the $x$-coordinate and the $y$-coordinate.
> Accordingly, specify a constructor `make-point` and selectors `x-point` and `y-point` that define this representation.
> Finally, using your selectors and constructors, define a procedure `midpoint-segment` that takes a line segment as argument and returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints).
> To try your procedures, you’ll need a way to print points:
> ```scheme
> (define (print-point p)
>   (newline)
>   (display "(")
>   (display (x-point p))
>   (display ",")
>   (display (y-point p))
>   (display ")"))
> ```

---

We use the following code to represent and print points:
```scheme
;;; Points

;;; Points

(define (make-point x y) (cons x y))

(define (x-point p) (car p))

(define (y-point p) (cdr p))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))
```

To represent lines we use the following code:
```scheme
;;; Lines

(define (make-segment p q)
  (cons p q))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))
```

Finally, we compute midpoints as follows:
```scheme
;;; Midpoint

(define (midpoint-segment s)
  (define (average x y)
    (/ (+ x y) 2))
  (let ((p-start (start-segment s))
        (p-end (end-segment s)))
    (let ((x-start (x-point p-start))
          (x-end (x-point p-end))
          (y-start (y-point p-start))
          (y-end (y-point p-end)))
      (make-point (average x-start x-end)
                  (average y-start y-end)))))
```

We can test our code with the following example:
```scheme
(define p (make-point 1 2))
(define q (make-point 7 8))
(define seg (make-segment p q))

(print-point (midpoint-segment seg))
```
The result is `(4 . 5)`, both with `mit-scheme` and with `racket`:
```text
$ mit-scheme --load exercise_2.02_test.scm
MIT/GNU Scheme running under GNU/Linux
Type `^C' (control-C) followed by `H' to obtain information about interrupts.

Copyright (C) 2022 Massachusetts Institute of Technology
This is free software; see the source for copying conditions. There is NO warranty; not
even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Image saved on Friday January 6, 2023 at 10:11:41 PM
  Release 12.1 || SF || LIAR/x86-64
;Loading "exercise_2.02_test.scm"...
;  Loading "exercise_2.02.scm"... done

(4, 5)
```
```text
$ racket -f exercise_2.02_test.scm 

(4, 5)
```
