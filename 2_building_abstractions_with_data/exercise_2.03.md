# Exercise 2.3

> Implement a representation for rectangles in a plane.
> (Hint: You may want to make use of Exercise 2.2.)
> In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle.
> Now implement a different representation for rectangles.
> Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?



From our point of view, there seem to be (at least) two natural ways of representing a rectangle:

- We can represent a rectangle by one of its corner points, its horizontal length, and its vertical length.
  Depending on the choice of corner point, there are four such representations.
  Our preferred corner is the bottom-left one (i.e., the corner with the smallest $x$-coordinate and smallest $y$-coordinate).

- We represent a rectangle by a set of opposing corner points.
  There are two such representations.
  Our preferred choice of corners are the bottom-left and top-right ones.

Both representations of rectangles require us to handle points:
```scheme
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))
```

We will implement `perimeter` and `area` in terms of auxiliary procedure `width` and `height`.
Both of these auxiliary procedures will later be implemented in a representation-dependent way, but `perimeter` and `area` do not depend on the choice of representation.
```scheme
(define (perimeter r)
  (+ (* 2 (height r))
     (* 2 (width r))))

(define (area r)
  (* (height r)
     (width r)))
```

The first representation of rectangles can be implemented as follows:
```scheme
(define (make-rect point width height)
  (cons point
        (cons width height)))

(define (width r)
  (car (cdr r)))

(define (height r)
  (cdr (cdr r)))
```

The second representation can be implemented as follows:
```scheme
(define (make-rect bl tr)
  (cons bl tr))

(define (bl-rect r)
  (car r))

(define (tr-rect r)
  (cdr r))

(define (width r)
  (let ((bl (bl-rect r))
        (tr (tr-rect r)))
    (- (x-point tr) (x-point bl))))

(define (height r)
  (let ((bl (bl-rect r))
        (tr (tr-rect r)))
    (- (y-point tr) (y-point bl))))
```
