;;; The following code can be tested in DrRacket with the SICP Collections
;;; (https://docs.racket-lang.org/sicp-manual/index.html) installed.

#lang sicp
(#%require sicp-pict)

(define (below painter1 painter2)
  (let ((border 0.5))
    (let ((below-painter
           (transform-painter painter1
                              (make-vect 0.0 0.0)      ; new origin
                              (make-vect 1.0 0.0)      ; new end of edge1
                              (make-vect 0.0 border))) ; new end of edge2
          (above-painter
           (transform-painter painter2
                              (make-vect 0.0 border) ; new origin
                              (make-vect 1.0 border) ; new end of edge1
                              (make-vect 0.0 1.0)))) ; new end of edge2
      (lambda (frame)
        (below-painter frame)
        (above-painter frame)))))


;;;     rotate270
;;; ∧  ───────────►  >  ───┐            ┌─────┬─────┐                ┌─────────┐
;;;                        │  beside    │     │     │   rotate90     │    ↑    │
;;;                        ├─────────►  │  >  │  →  │  ──────────►   ├─────────┤
;;;     rotate270          │            │     │     │                │    ∧    │
;;; ↑  ───────────►  →  ───┘            └─────┴─────┘                └─────────┘

(define (below painter1 painter2)
  (rotate90 (beside (rotate270 painter1)
                    (rotate270 painter2))))



;;; Test

(display "Normal above, rotated below")
(newline)
(paint (below (rotate180 einstein) einstein))
