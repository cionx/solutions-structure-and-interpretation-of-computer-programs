;;; The following code can be tested in DrRacket with the SICP Collections
;;; (https://docs.racket-lang.org/sicp-manual/index.html) installed.

#lang sicp
(#%require sicp-pict)

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)   ; new origin
                     (make-vect 0.0 0.0)   ; new end of edge1
                     (make-vect 1.0 1.0))) ; new end of edge2

(define (rotate180 painter)
  (rotate90 (rotate90 painter)))

(define (rotate270 painter)
  (rotate180 (rotate90 painter)))

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

;;; Testing

(display "original")
(newline)
(paint einstein)

(display "horizontally flipped")
(newline)
(paint (flip-horiz einstein))

(display "rotated by 90 degrees")
(newline)
(paint (rotate90 einstein))

(display "rotated by 180 degrees")
(newline)
(paint (rotate180 einstein))

(display "rotated by 270 degrees")
(newline)
(paint (rotate270 einstein))
