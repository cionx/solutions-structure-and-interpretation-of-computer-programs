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


We use the following code:
```scheme
;;; Points

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

;;; Lines

(define (make-segment p q)
  (cons p q))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

;;; Midpoint

(define (midpoint-segment s)
  (define (average x y)
    (/ (+ x y) 2))
  (let ((p1 (start-segment s))
        (p2 (end-segment s)))
    (let ((x1 (x-point p1))
          (x2 (x-point p2))
          (y1 (y-point p1))
          (y2 (y-point p2)))
      (make-point (average x1 x2) (average y1 y2)))))
```
