# Exercise 2.50

> Define the transformation `flip-horiz`, which flips painters horizontally, and transformations that rotate painters counterclockwise by $180$ degrees and $270$ degrees.


We can write the procedure `flip-horizon` as follows:
```scheme
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)   ; new origin
                     (make-vect 0.0 0.0)   ; new end of edge1
                     (make-vect 1.0 1.0))) ; new end of edge2
```
The procedures `rotate180` and `rotate270` can be implemented the terms of the already defined `rotate90`:
```scheme
(define (rotate180 painter)
  (rotate90 (rotate90 painter)))

(define (rotate270 painter)
  (rotate180 (rotate90 painter)))
```

Alternatively, we could implement `rotate180` and `rotate270` explicitly in terms of `transform-painter` as follows:
```scheme
(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)   ; new origin
                     (make-vect 0.0 1.0)   ; new end of edge1
                     (make-vect 1.0 0.1))) ; new end of edge2

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)   ; new origin
                     (make-vect 0.0 0.0)   ; new end of edge1
                     (make-vect 1.0 1.0))) ; new end of edge2
```
