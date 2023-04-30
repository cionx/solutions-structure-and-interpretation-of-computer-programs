;;; This code can be tested in DrRacket with the SICP Collections
;;; (https://docs.racket-lang.org/sicp-manual/index.html) installed.

#lang sicp
(#%require sicp-pict)

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter
               (beside smaller smaller)))))



;;; Testing

(display 0)
(newline)
(paint (up-split einstein 0))

(display 1)
(newline)
(paint (up-split einstein 1))

(display 2)
(newline)
(paint (up-split einstein 2))

(display 3)
(newline)
(paint (up-split einstein 3))
